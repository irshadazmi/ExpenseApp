# app/services/ai_service.py

import json
import os
import re
import hashlib
import subprocess
from typing import List, Dict, Optional, Any
from datetime import datetime, date
import uuid

from fastapi import UploadFile
import httpx

from app.repositories.ai_repository import AIRepository
from app.repositories.semantic_repository import SemanticRepository
from app.utils.llm_client import ask_llm
from app.schemas.ai_schema import AIChatResponse, AICategorizeResponse, AIInsight
from app.ai.intent_engine import IntentEngine, IntentType
from app.core.config import settings
from app.ai.forecast_engine import ForecastEngine
from app.ai.anomaly_engine import AnomalyEngine
from app.ai.explanation_engine import ExplanationEngine

# ---------------------------------------
# Whisper paths (self-contained)
# ---------------------------------------
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# backend-api/app/services → go up to backend-api/
WHISPER_DIR = os.path.abspath(os.path.join(BASE_DIR, "..", "..", "whisper"))

WHISPER_EXE = os.path.join(WHISPER_DIR, "whisper-cli.exe")
MODEL_FILE = os.path.join(WHISPER_DIR, "ggml-medium.bin")
FFMPEG_EXE = os.path.join(WHISPER_DIR, "ffmpeg.exe")
PROFILE_THRESHOLD_LOW = 300      # conservative
PROFILE_THRESHOLD_HIGH = 1000    # spender

# ---------------------------
# Helpers
# ---------------------------
def _is_financial_text(txt: str) -> bool:
    """Quick heuristic — extend as needed."""
    return bool(
        re.search(
            r"\b(spend|expense|budget|income|total|last|transactions|category|balance|how much|spent)\b",
            txt,
            re.I,
        )
    )

def contains_non_english(text: str) -> bool:
    # Detect any non-latin script (Urdu, Hindi, Marathi, Arabic, etc.)
    return bool(re.search(r"[^\u0000-\u007F]", text))

def _serialize_for_json(obj: Any) -> Any:
    """
    Make a Python object JSON-serializable by converting datetimes to ISO strings
    and recursively handling containers. Avoids TypeError when json.dumps is called later.
    """
    if obj is None:
        return None
    if isinstance(obj, (str, int, float, bool)):
        return obj
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    if isinstance(obj, dict):
        return {str(k): _serialize_for_json(v) for k, v in obj.items()}
    if isinstance(obj, (list, tuple, set)):
        return [_serialize_for_json(v) for v in obj]
    # Fallback: convert to string
    return str(obj)


def currency_symbol(cur: str) -> str:
    return {
        "INR": "₹",
        "USD": "$",
        "EUR": "€",
        "GBP": "£",
    }.get((cur or "").upper(), "")


def validate_sql(sql: str) -> str:
    BAD_WORDS = ["drop", "delete", "truncate", "alter", "update", "insert", "create"]
    checking = (sql or "").lower()
    for w in BAD_WORDS:
        if w in checking:
            raise ValueError(f"Unsafe SQL generated: {w}")
    sql = sql.strip()
    return sql if sql.endswith(";") else sql + ";"


def extract_sql_from_text(txt: str) -> str:
    txt = re.sub(r"```sql", "", txt, flags=re.I)
    txt = re.sub(r"```", "", txt)
    m = re.search(r"(?is)(select|with)\s", txt)
    if m:
        txt = txt[m.start() :]
    if ";" in txt:
        txt = txt.split(";", 1)[0] + ";"
    return txt.strip()

async def _compute_user_profile(self, user_id: int):
    avg_daily_spend = await self.repo.get_avg_daily_spend(user_id)

    if avg_daily_spend < PROFILE_THRESHOLD_LOW:
        style = "conservative"
    elif avg_daily_spend > PROFILE_THRESHOLD_HIGH:
        style = "spender"
    else:
        style = "balanced"

    await self.repo.upsert_user_financial_profile(
        user_id=user_id,
        spending_style=style,
        avg_daily_spend=avg_daily_spend,
    )

# ---------------------------
# AI Service
# ---------------------------
class AIService:
    def __init__(self, repo: AIRepository):
        self.repo = repo
        self.semantic_repo = SemanticRepository(repo.db)
        self.intent_engine = IntentEngine()

        # Ollama configs
        self._ollama_base = settings.OLLAMA_BASE_URL
        self._embed_model = settings.OLLAMA_EMBED_MODEL

        self._similarity_threshold = 0.82

    # -----------------------
    # Fast async embedding (Ollama)
    # -----------------------
    async def _embed_async(self, text: str) -> List[float]:
        if not self._ollama_base:
            raise RuntimeError("OLLAMA_BASE_URL not configured")
        async with httpx.AsyncClient(timeout=30.0) as client:
            resp = await client.post(
                f"{self._ollama_base}/api/embeddings",
                json={"model": self._embed_model, "prompt": text},
            )
        resp.raise_for_status()
        data = resp.json()
        # Ollama / nomic-embed-text returns embedding in different shapes sometimes;
        # assume top-level "embedding" key is present.
        emb = data.get("embedding") or data.get("data")  # fallback
        if emb is None:
            raise RuntimeError("Embedding response missing 'embedding'")
        return emb
    
    # -------------------------------------------------------
    # Transcribe
    # -------------------------------------------------------
    async def transcribe(self, file: UploadFile) -> str:
        # --- Debug paths ---
        print("WHISPER_DIR =", WHISPER_DIR)
        print("WHISPER_EXE exists =", os.path.exists(WHISPER_EXE))
        print("MODEL_FILE exists =", os.path.exists(MODEL_FILE))

        file_id = uuid.uuid4().hex
        input_m4a = os.path.join(WHISPER_DIR, f"{file_id}.m4a")
        input_wav = os.path.join(WHISPER_DIR, f"{file_id}.wav")
        output_txt = input_wav + ".txt"

        # --- Save uploaded file ---
        raw = await file.read()
        print("DEBUG: Uploaded file bytes =", len(raw))

        with open(input_m4a, "wb") as f:
            f.write(raw)

        # --- Convert M4A → WAV ---
        ffmpeg_cmd = [
            FFMPEG_EXE,
            "-y",
            "-i", input_m4a,
            "-ar", "16000",
            "-ac", "1",
            input_wav
        ]

        proc = subprocess.run(
            ffmpeg_cmd,
            cwd=WHISPER_DIR,         # <- SUPER IMPORTANT
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )

        print("DEBUG ffmpeg stderr:", proc.stderr)

        if not os.path.exists(input_wav):
            print("DEBUG: WAV NOT CREATED")
            return ""

        print("DEBUG: WAV SIZE =", os.path.getsize(input_wav))

        # --- Run whisper-cli.exe ---
        whisper_cmd = [
            WHISPER_EXE,
            "-m", MODEL_FILE,
            "-f", input_wav,
            "-otxt",
            "--translate",
            "-l", "mr"   # ⭐ Marathi hint
        ]

        subprocess.run(
            whisper_cmd,
            cwd=WHISPER_DIR,         # <- also required
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        # --- Read output ---
        if not os.path.exists(output_txt):
            print("DEBUG: Whisper .txt NOT FOUND")
            return ""

        with open(output_txt, "r", encoding="utf-8") as f:
            text = f.read().strip()

        print("DEBUG: Whisper text:", text)
        return text

    # -------------------------------------------------------
    # VOICE CHAT → Whisper → Chat
    # -------------------------------------------------------
    async def voice_chat(self, user_id: int, file: UploadFile) -> AIChatResponse:
        # 1️⃣ Transcribe audio
        spoken_text = await self.transcribe(file)

        if not spoken_text.strip():
            return AIChatResponse(
                answer="I couldn't understand the audio. Please try again.",
                sql_used=None,
                rows=[],
                voice_text=spoken_text,
            )

        normalized_text = spoken_text

        # 2️⃣ 🔑 FORCE TRANSLATION IF NON-ENGLISH SCRIPT
        if contains_non_english(spoken_text):
            try:
                translate_prompt = f"""
                Translate the following sentence into English.
                Return ONLY the translated sentence.

                Sentence:
                {spoken_text}
                """
                normalized_text = (await ask_llm(translate_prompt)).strip()
            except Exception:
                normalized_text = spoken_text  # fallback safely

        # 3️⃣ NOW run finance logic on ENGLISH text
        chat_res = await self.chat(
            user_id=user_id,
            question=normalized_text
        )

        # 4️⃣ Return response
        return AIChatResponse(
            answer=chat_res.answer,
            sql_used=chat_res.sql_used,
            rows=chat_res.rows,
            voice_text=spoken_text,  # what user actually spoke
        )

    # -----------------------
    # Chat entrypoint
    # -----------------------
    async def chat(self, user_id: int, question: str) -> AIChatResponse:

        # Quick heuristic: if transcription isn't about finances, avoid running LLM/SQL
        if not _is_financial_text(question):
            # still check intent_engine for explicit intents (e.g., user said "show last 5 transactions")
            intent_match = self.intent_engine.match_intent(question)
            if intent_match.intent == IntentType.UNKNOWN:
                return AIChatResponse(
                    answer="I couldn't find a finance-related question in your input. Please ask about spending, budgets, categories or transactions.",
                    sql_used=None,
                    rows=[],
                )

        # 1) embedding + semantic cache lookup
        try:
            query_embedding = await self._embed_async(question)
        except Exception as e:
            # embedding failure — log upstream, fallback to normal flow without cache
            query_embedding = None

        cache_hit = None
        if query_embedding is not None:
            try:
                similar = await self.semantic_repo.search_similar(
                    query_embedding, limit=3
                )
                if similar:
                    best = similar[0]
                    distance = float(best.get("distance", 1.0))
                    similarity = 1.0 - distance
                    if similarity >= self._similarity_threshold:
                        cache_hit = best
            except Exception:
                # if vector-search fails, continue without cache
                cache_hit = None

        if cache_hit:
            # semantic_repository returns 'metadata' (jsonb) — we previously stored response object in metadata
            md = cache_hit.get("metadata") or {}
            # possible shapes:
            # 1) metadata == response_obj
            # 2) metadata == {"response": {...}, "cache_key": "..."}
            # 3) older tables had 'response' column — semantic_repository might return it as 'response'
            saved = None
            if isinstance(md, dict):
                # prefer explicit 'response'
                saved = md.get("response") or md
            else:
                # md may be string (JSON), semantic_repository should decode it, but be defensive
                try:
                    saved = json.loads(md)
                except Exception:
                    saved = None

            if not saved and "response" in cache_hit:
                saved = cache_hit.get("response")

            if saved:
                # saved should contain {answer, sql_used, rows} if stored by our code
                return AIChatResponse(
                    answer=saved.get("answer", "Cached result"),
                    sql_used=saved.get("sql_used"),
                    rows=saved.get("rows", []),
                )

        # 2) Intent engine → SQL mapping
        intent_match = self.intent_engine.match_intent(question)
        intent = intent_match.intent
        category_asked = intent_match.category

        sql: Optional[str] = None

        if intent == IntentType.TOTAL_THIS_MONTH:
            sql = f"""
                SELECT SUM(amount) AS sum, currency
                FROM transactions
                WHERE user_id={user_id}
                  AND type='Expense'
                  AND EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM CURRENT_DATE)
                  AND EXTRACT(MONTH FROM transaction_date) = EXTRACT(MONTH FROM CURRENT_DATE)
                GROUP BY currency
                LIMIT 5;
            """

        elif intent == IntentType.CATEGORY_SPEND and category_asked:
            sql = f"""
                SELECT SUM(t.amount) AS sum, t.currency
                FROM transactions t
                JOIN categories c ON t.category_id=c.id
                WHERE t.user_id={user_id}
                  AND t.type='Expense'
                  AND LOWER(c.name) LIKE '%' || LOWER('{category_asked}') || '%'
                GROUP BY t.currency
                LIMIT 5;
            """

        elif intent == IntentType.TOP_CATEGORY:
            sql = f"""
                SELECT c.name, SUM(t.amount) AS sum, t.currency
                FROM transactions t
                JOIN categories c ON t.category_id=c.id
                WHERE t.user_id={user_id}
                  AND t.type='Expense'
                GROUP BY c.name, t.currency
                ORDER BY SUM(t.amount) DESC
                LIMIT 1;
            """

        elif intent == IntentType.OVER_BUDGET:
            sql = f"""
                SELECT c.name,
                       SUM(t.amount) AS spent,
                       b.amount AS budget,
                       t.currency
                FROM budgets b
                JOIN categories c ON c.id=b.category_id
                JOIN transactions t ON t.category_id=c.id
                WHERE b.user_id={user_id}
                  AND t.user_id={user_id}
                  AND t.type='Expense'
                GROUP BY c.name, b.amount, t.currency
                HAVING SUM(t.amount) > b.amount
                ORDER BY SUM(t.amount)-b.amount DESC
                LIMIT 5;
            """

        elif intent == IntentType.REMAINING_BUDGET:
            sql = f"""
                SELECT
                    b.currency,
                    SUM(b.amount) - (
                        SELECT COALESCE(SUM(t.amount),0)
                        FROM transactions t
                        WHERE t.user_id={user_id}
                          AND t.type='Expense'
                    ) AS remaining
                FROM budgets b
                WHERE b.user_id={user_id}
                GROUP BY b.currency
                LIMIT 5;
            """

        elif intent == IntentType.LAST_TRANSACTIONS:
            sql = f"""
                SELECT
                    t.description,
                    t.amount,
                    t.currency,
                    c.name AS category,
                    t.type
                FROM transactions t
                LEFT JOIN categories c ON c.id=t.category_id
                WHERE t.user_id={user_id}
                ORDER BY t.transaction_date DESC
                LIMIT 5;
            """

        # fallback to LLM -> SQL (SAFE)
        if not sql:
            # extra safety: if question looks non-financial, return friendly message
            if not _is_financial_text(question):
                return AIChatResponse(
                    answer="I couldn't understand a finance-related question. Please ask about spending, budgets, categories or transactions.",
                    sql_used=None,
                    rows=[],
                )

            prompt = f"""
                Translate the question into a PostgreSQL SELECT SQL query.

                STRICT RULES (must be followed exactly):
                - Only SELECT queries are allowed.
                - NEVER use "SELECT *" on the transactions table.
                - All queries MUST include "user_id={user_id}".
                - All queries MUST include a LIMIT clause (e.g., LIMIT 5 or LIMIT 10).
                - Prefer aggregated queries (SUM, COUNT) for summaries.
                - Do not return full tables or large lists.
                - End with a semicolon and return ONLY the SQL (no explanation or markdown).

                Question:
                {question}

                SQL:
                """
            raw = await ask_llm(prompt)
            sql_candidate = extract_sql_from_text(raw)
            sql_candidate = validate_sql(sql_candidate)

            # additional restrictions: block SELECT * FROM transactions
            if re.search(r"select\s+\*\s+from\s+transactions", sql_candidate, re.I):
                # override with safe last transactions query
                sql_candidate = f"""
                    SELECT t.description, t.amount, t.currency, c.name as category, t.type
                    FROM transactions t
                    LEFT JOIN categories c ON c.id=t.category_id
                    WHERE t.user_id={user_id}
                    ORDER BY t.transaction_date DESC
                    LIMIT 5;
                """
            sql = sql_candidate

        # 3) Execute SQL
        rows = await self.repo.run_sql(sql)

        # 4) Format result
        answer = self._format_answer(rows, category_asked)

        # 5) Save into semantic cache (if embedding available)
        try:
            serialized_response = _serialize_for_json(
                {
                    "answer": answer,
                    "sql_used": sql,
                    "rows": rows,
                }
            )
            if query_embedding is not None:
                cache_key = hashlib.sha1(question.strip().lower().encode()).hexdigest()
                await self.semantic_repo.upsert_cache(
                    user_id=user_id,
                    cache_key=cache_key,
                    query_text=question,
                    embedding=query_embedding,
                    response_obj=serialized_response,  # semantic repo will JSON-ify this into metadata
                )
        except Exception:
            # non-fatal; caching failure should not break response
            pass

        return AIChatResponse(answer=answer, sql_used=sql, rows=rows)

    # -----------------------
    # Format answer (robust)
    # -----------------------
    def _format_answer(self, rows: List[Dict], category: Optional[str]) -> str:
        if not rows:
            sym = currency_symbol("INR")
            if category:
                return f"You have spent {sym}0.00 on {category}."
            return f"You have spent {sym}0.00."

        row = rows[0]

        # Most spent category
        if "name" in row and ("sum" in row or "total_spent" in row):
            amt = row.get("sum") or row.get("total_spent")
            sym = currency_symbol(row.get("currency", "INR"))
            try:
                amt_f = float(amt or 0)
            except Exception:
                amt_f = 0.0
            return f"You spent the most on {row.get('name')} ({sym}{amt_f:,.2f})."

        # Total / Category sum
        if "sum" in row:
            try:
                total = float(row["sum"] or 0)
            except Exception:
                total = 0.0
            sym = currency_symbol(row.get("currency", "INR"))
            if category:
                return f"You have spent {sym}{total:,.2f} on {category}."
            return f"You have spent {sym}{total:,.2f}."

        # Over budget
        if "spent" in row and "budget" in row:
            sym = currency_symbol(row.get("currency", "INR"))
            try:
                diff = float(row["spent"]) - float(row["budget"])
            except Exception:
                diff = 0.0
            name = row.get("name", "Category")
            return f"{name} exceeded your budget by {sym}{diff:,.2f}."

        # Remaining budget
        if "remaining" in row:
            sym = currency_symbol(row.get("currency", "INR"))
            try:
                rem = float(row["remaining"])
            except Exception:
                rem = 0.0
            return f"Your remaining budget is {sym}{rem:,.2f}."

        # Last transactions (list)
        # note: rows may or may not include 'category' column (if user SQL selected category_id only)
        if any("description" in r for r in rows):
            lines: List[str] = []
            for r in rows:
                typ = r.get("type", "Txn")
                # prefer 'category' (joined name), else fallback to category_id or 'Uncategorized'
                if r.get("category"):
                    cat_name = r.get("category")
                elif r.get("category_id"):
                    cat_name = f"Category {r.get('category_id')}"
                else:
                    # sometimes description itself includes text like "Expense - Housing"
                    cat_name = "Uncategorized"

                # amount formatting
                amt = r.get("amount", 0)
                try:
                    amt_f = float(amt or 0)
                except Exception:
                    # if amount is text, try numeric extraction
                    try:
                        amt_f = float(re.sub(r"[^\d.]", "", str(amt)) or 0)
                    except Exception:
                        amt_f = 0.0

                sym = currency_symbol(r.get("currency", "INR"))
                lines.append(f"{typ} - {cat_name} - {sym}{amt_f}")
            return "Last 5 transactions:\n" + "\n".join(lines)

        # generic fallback
        return "Query executed successfully."

    # -----------------------
    # Categorize (unchanged)
    # -----------------------
    async def categorize(self, description: str) -> AICategorizeResponse:
        cats = await self.repo.get_categories()

        prompt = f"""
            Pick BEST category_id.

            CATEGORIES:
            {chr(10).join(f"{c['id']}: {c['name']}" for c in cats)}

            JSON ONLY:
            {{"category_id":1,"confidence":0.75}}

            DESCRIPTION:
            "{description}"
        """

        raw = await ask_llm(prompt)

        cat_id = None
        conf = 0.3

        try:
            data = json.loads(raw)
            cat_id = int(data["category_id"])
            conf = float(data.get("confidence", conf))
        except Exception:
            pass

        valid_ids = {c["id"] for c in cats}
        if cat_id not in valid_ids:
            cat_id = cats[-1]["id"]

        return AICategorizeResponse(category_id=cat_id, confidence=conf)

    # -----------------------
    # Insights 
    # -----------------------
    async def generate_insights(self, user_id: int) -> List[AIInsight]:
        insights: List[AIInsight] = []

        today = date.today()
        year, month = today.year, today.month

        # ====================================================
        # Monthly Summary
        # ====================================================
        monthly = await self.repo.get_monthly_totals(user_id)
        for r in monthly:
            insights.append(
                AIInsight(
                    insight_type="SUMMARY",
                    title="Monthly Spending Summary",
                    severity="LOW",
                    message=f"You have spent {r['currency']} {r['spent']:,.2f} so far this month.",
                )
            )

        cat_usage = await self.repo.get_category_usage(user_id)
        for c in cat_usage:
            spent = float(c["spent"] or 0)
            budget = float(c["budget"] or 0)
            if budget == 0:
                continue
            percent = (spent / budget) * 100

            if percent >= 100:
                insights.append(
                    AIInsight(
                        insight_type="BUDGET_STATUS",
                        title=f"{c['name']} over budget",
                        severity="HIGH",
                        message=f"{c['name']} exceeded its budget by {(percent - 100):.1f}%.",
                        category_id=None,
                    )
                )
            elif percent >= 80:
                insights.append(
                    AIInsight(
                        insight_type="BUDGET_STATUS",
                        title=f"{c['name']} nearing limit",
                        severity="MEDIUM",
                        message=f"{c['name']} has used {percent:.1f}% of its budget.",
                    )
                )

        # ====================================================
        # Forecast
        # ====================================================

        forecast_engine = ForecastEngine(self.repo.db)
        anomaly_engine = AnomalyEngine(self.repo.db)

        forecasts = await forecast_engine.generate_monthly_forecast(
            user_id=user_id,
            year=year,
            month=month,
        )

        for f in forecasts:
            if f.severity == "LOW":
                continue

            insights.append(
                AIInsight(
                    insight_type="BUDGET_FORECAST",
                    title=f"{f.category_name} budget at risk",
                    severity=f.severity,
                    message=(
                        f"At your current pace, you will exceed this budget "
                        f"by ₹{max(f.projected_spend - f.budget_amount, 0):.0f} "
                        f"in {f.days_to_exceed} days."
                    ),
                    category_id=f.category_id,
                    confidence=f.confidence,
                    metadata={
                        "projected_spend": f.projected_spend,
                        "budget": f.budget_amount,
                    },
                )
            )

        # ====================================================
        # Anomalies
        # ====================================================
        anomalies = await anomaly_engine.detect_monthly_anomalies(
            user_id, year, month
        )

        for a in anomalies:
            insights.append(AIInsight(**a))

        # ====================================================
        # Explanation
        # ====================================================
        explainer = ExplanationEngine()

        for i in insights:
            i.metadata["why"] = explainer.explain(i)

        insights = self._deduplicate_insights(insights)
        return insights
    
    # -----------------------
    # Deduplicate 
    # -----------------------
    def _deduplicate_insights(self, insights: List[AIInsight]) -> List[AIInsight]:
        by_category = {}
        final: List[AIInsight] = []

        for i in insights:
            key = i.category_id or f"global:{i.insight_type}"
            if key not in by_category:
                by_category[key] = []
            by_category[key].append(i)

        for key, items in by_category.items():
            # If forecast exists, drop budget_status
            has_forecast = any(i.insight_type == "BUDGET_FORECAST" for i in items)
            if has_forecast:
                items = [i for i in items if i.insight_type != "BUDGET_STATUS"]

            final.extend(items)

        return final


    
