import json
import re
from datetime import datetime
from typing import List, Dict, Optional

from app.repositories.ai_repository import AIRepository
from app.utils.llm_client import ask_llm
from app.schemas.ai_schema import (
    AIChatResponse,
    AICategorizeResponse,
    AIInsight,
)


# ==========================================================
# BASIC SQL SAFETY
# ==========================================================


def validate_sql(sql: str) -> str:
    BAD_WORDS = ["drop", "delete", "truncate", "alter", "update", "insert"]

    checking = sql.lower()
    for w in BAD_WORDS:
        if w in checking:
            raise ValueError(f"Unsafe SQL generated: {w}")

    sql = sql.strip()
    if not sql.endswith(";"):
        sql += ";"

    return sql


def extract_sql_from_text(txt: str) -> str:
    # Remove markdown
    txt = re.sub(r"```sql", "", txt, flags=re.I)
    txt = re.sub(r"```", "", txt)

    # Find SQL starting point
    m = re.search(r"(?is)(select|with)\s", txt)
    if m:
        txt = txt[m.start():]

    # Keep ONLY up to first semicolon (strip LLM notes)
    if ";" in txt:
        txt = txt.split(";", 1)[0] + ";"

    return txt.strip()


# ==========================================================
# QUESTION PARSING
# ==========================================================


def extract_category_from_question(q: str) -> Optional[str]:

    # Pattern 1 → "spend on Food & Dining"
    m = re.search(
        r"(?:spend|spent|spending)\s+(?:on|for)\s+(.+?)\??$",
        q,
        re.I,
    )
    if m:
        return m.group(1).strip()

    # Pattern 2 → "Food spend" or "Food spent"
    m = re.search(
        r"(.+?)\s+(?:spend|spent)\??$",
        q,
        re.I,
    )
    if m:
        return m.group(1).strip()

    return None


def is_question(q: str, keys: List[str]) -> bool:
    q = q.lower()
    return all(k in q for k in keys)


# ==========================================================
# CURRENCY
# ==========================================================


def currency_symbol(cur: str) -> str:
    return {
        "INR": "₹",
        "USD": "$",
        "EUR": "€",
        "GBP": "£",
    }.get(cur.upper(), "")


# ==========================================================
# SERVICE
# ==========================================================


class AIService:
    def __init__(self, repo: AIRepository):
        self.repo = repo

    # ------------------------------------------------------
    # CHAT ENTRYPOINT
    # ------------------------------------------------------
    async def chat(self, user_id: int, question: str) -> AIChatResponse:

        q = question.lower().strip()

        # ==================================================
        # ✅ FAQ FALLBACK ENGINE (NO LLM)
        # ==================================================

        sql: Optional[str] = None
        category_asked = extract_category_from_question(question)

        # ---------------------------
        # TOTAL MONTHLY SPENT
        # ---------------------------
        if is_question(q, ["total", "this", "month"]):

            sql = f"""
            SELECT SUM(amount) AS sum, currency
            FROM transactions
            WHERE user_id={user_id}
              AND type='Expense'
              AND transaction_date >= date_trunc('month', CURRENT_DATE)
              AND transaction_date < date_trunc('month', CURRENT_DATE) + interval '1 month'
            GROUP BY currency;
            """

        # ---------------------------
        # SPENT BY CATEGORY
        # ---------------------------
        elif category_asked:

            sql = f"""
            SELECT SUM(t.amount) AS sum, t.currency
            FROM transactions t
            JOIN categories c ON t.category_id=c.id
            WHERE t.user_id={user_id}
              AND t.type='Expense'
              AND LOWER(c.name) LIKE '%' || LOWER('{category_asked}') || '%'
            GROUP BY t.currency;
            """

        # ---------------------------
        # ✅ MOST / TOP SPENT CATEGORY  (FIXED MATCHING)
        # ---------------------------
        elif (
            is_question(q, ["most", "category"])
            or is_question(q, ["top", "category"])
            or is_question(q, ["top", "spend"])
            or is_question(q, ["highest", "category"])
        ):

            sql = f"""
            SELECT c.name, SUM(t.amount) AS sum, t.currency
            FROM transactions t
            JOIN categories c ON t.category_id=c.id
            WHERE t.user_id={user_id}
              AND t.type='Expense'
            GROUP BY c.name,t.currency
            ORDER BY SUM(t.amount) DESC
            LIMIT 1;
            """

        # ---------------------------
        # OVER BUDGET CATEGORY
        # ---------------------------
        elif is_question(q, ["exceed", "budget"]):

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
            GROUP BY c.name,b.amount,t.currency
            HAVING SUM(t.amount) > b.amount
            ORDER BY SUM(t.amount)-b.amount DESC
            LIMIT 1;
            """

        # ---------------------------
        # REMAINING BUDGET
        # ---------------------------
        elif is_question(q, ["remaining", "budget"]):

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
            GROUP BY b.currency;
            """

        # ---------------------------
        # LAST 5 TRANSACTIONS
        # ---------------------------
        elif is_question(q, ["last", "5", "transaction"]):

            sql = f"""
            SELECT
              t.description,
              t.amount,
              t.currency,
              c.name AS category,
              t.type
            FROM transactions t
            JOIN categories c ON c.id=t.category_id
            WHERE t.user_id={user_id}
            ORDER BY t.transaction_date DESC
            LIMIT 5;
            """

        # ==================================================
        # ✅ USE LLM ONLY IF NO FAQ MATCH
        # ==================================================
        if not sql:

            prompt = f"""
                Translate the question into a PostgreSQL SELECT SQL query.

                TABLE categories(id,name)
                TABLE transactions(id,amount,type,currency,category_id,user_id,transaction_date)

                Rules:
                - Only SELECT allowed
                - Must filter user_id={user_id}
                - No markdown text
                - End with semicolon
                - No explanation

                Question:
                {question}

                SQL:
                """

            raw = await ask_llm(prompt)
            sql = extract_sql_from_text(raw)
            sql = validate_sql(sql)

        # ==================================================
        # RUN SQL
        # ==================================================
        rows: List[Dict] = await self.repo.run_sql(sql)

        answer = self._format_answer(rows, category_asked)

        return AIChatResponse(
            answer=answer,
            sql_used=sql,
            rows=rows,
        )

    # ------------------------------------------------------
    # FORMAT RESULTS → NATURAL LANGUAGE
    # ------------------------------------------------------
    def _format_answer(
        self,
        rows: List[Dict],
        category: Optional[str],
    ) -> str:

        # ✅ No rows means zero spending
        if not rows:
            sym = currency_symbol("INR")
            if category:
                return f"You have spent {sym}0.00 on {category}."
            return f"You have spent {sym}0.00."

        row = rows[0]

        # MOST SPENT CATEGORY
        if "name" in row and ("sum" in row or "total_spent" in row):
            amt = row.get("sum") if "sum" in row else row.get("total_spent")
            sym = currency_symbol(row.get("currency", "INR"))
            return f"You spent the most on {row['name']} ({sym}{float(amt):,.2f})."

        # TOTAL / CATEGORY SUM
        if "sum" in row:
            total = row["sum"] or 0
            sym = currency_symbol(row.get("currency", "INR"))

            if category:
                return f"You have spent {sym}{total:,.2f} on {category}."

            return f"You have spent {sym}{total:,.2f}."

        # OVER BUDGET
        if "spent" in row and "budget" in row and "name" in row:
            sym = currency_symbol(row.get("currency", "INR"))
            diff = float(row["spent"]) - float(row["budget"])
            return f"{row['name']} exceeded your budget by {sym}{diff:,.2f}."

        # REMAINING BUDGET
        if "remaining" in row:
            sym = currency_symbol(row.get("currency", "INR"))
            return f"Your remaining budget is {sym}{row['remaining']:,.2f}."

        # TRANSACTION LIST
        if "description" in row:
            lines = []
            for r in rows:
                s = currency_symbol(r["currency"])
                lines.append(f"{r['type']} - {r['category']} - {s}{r['amount']}")
            return "Last 5 transactions:\n" + "\n".join(lines)

        return "Query executed successfully."

    # ------------------------------------------------------
    # CATEGORIZE
    # ------------------------------------------------------
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
        except:
            pass

        valid_ids = {c["id"] for c in cats}

        if cat_id not in valid_ids:
            cat_id = cats[-1]["id"]

        return AICategorizeResponse(category_id=cat_id, confidence=conf)

    async def generate_insights(self, user_id: int) -> List[AIInsight]:

        insights: List[AIInsight] = []

        # -----------------------------
        # Monthly Total
        # -----------------------------
        monthly = await self.repo.get_monthly_totals(user_id)

        for r in monthly:
            spent = r["spent"]
            currency = r["currency"]

            insights.append(
                AIInsight(
                    title="Monthly Spending Summary",
                    severity="low",
                    message=f"You have spent {currency} {spent:,.2f} so far this month."
                )
            )

        # -----------------------------
        # Budget Overuse
        # -----------------------------
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
                        title=f"{c['name']} over budget",
                        severity="high",
                        message=f"{c['name']} exceeded its budget by {(percent-100):.1f}%."
                    )
                )

            elif percent >= 80:
                insights.append(
                    AIInsight(
                        title=f"{c['name']} nearing limit",
                        severity="medium",
                        message=f"{c['name']} has used {percent:.1f}% of its budget."
                    )
                )

        # -----------------------------
        # Spending Concentration
        # -----------------------------
        top = await self.repo.get_top_categories(user_id)

        if top:
            names = ", ".join(x["name"] for x in top)

            insights.append(
                AIInsight(
                    title="Top spending categories",
                    severity="low",
                    message=f"Most of your expenses come from: {names}."
                )
            )

        return insights
