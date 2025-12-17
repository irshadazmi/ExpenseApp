# app/services/intent_engine.py

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import Optional, List, Tuple

import re

from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_core.documents import Document

from app.core.config import settings


class IntentType(str, Enum):
    TOTAL_THIS_MONTH = "total_this_month"
    CATEGORY_SPEND = "category_spend"
    TOP_CATEGORY = "top_category"
    OVER_BUDGET = "over_budget"
    REMAINING_BUDGET = "remaining_budget"
    LAST_TRANSACTIONS = "last_transactions"
    UNKNOWN = "unknown"


@dataclass
class IntentMatch:
    intent: IntentType
    category: Optional[str] = None
    # optional: similarity score (for debugging / logs)
    score: Optional[float] = None


class IntentEngine:
    """
    Hybrid intent engine:
    1) Rule-based (cheap, deterministic)
    2) Semantic (Ollama embeddings + FAISS via LangChain)
    """

    def __init__(
        self,
        embed_model: Optional[str] = None,
        base_url: Optional[str] = None,
        semantic_enabled: bool = True,
        semantic_threshold: float = 0.35,
    ) -> None:
        """
        semantic_threshold:
          - FAISS 'score' is L2 distance for normalized vectors (lower = closer)
          - So we treat scores < threshold as a good semantic match.
        """
        self.semantic_enabled = semantic_enabled
        self.semantic_threshold = semantic_threshold

        self.embed_model = embed_model or settings.OLLAMA_EMBED_MODEL
        self.base_url = base_url or (settings.OLLAMA_BASE_URL or "http://localhost:11434")

        self._embed = None
        self._vectorstore = None

        if self.semantic_enabled:
            self._init_semantic_index()

    # --------------------------------------------------
    # PUBLIC API
    # --------------------------------------------------
    def match_intent(self, question: str) -> IntentMatch:
        """
        Main entrypoint.
        1) Try rule-based parsing.
        2) If not matched, try semantic retrieval.
        3) Fall back to UNKNOWN.
        """
        q = (question or "").strip()

        # 1) Rule-based – fast and deterministic
        rule_match = self._rule_based_intent(q)
        if rule_match is not None:
            return rule_match

        # 2) Semantic – embeddings + FAISS
        if self.semantic_enabled and self._vectorstore is not None:
            semantic_match = self._semantic_intent(q)
            if semantic_match is not None:
                return semantic_match

        # 3) Fallback
        return IntentMatch(intent=IntentType.UNKNOWN)

    # --------------------------------------------------
    # RULE-BASED INTENT
    # --------------------------------------------------
    def _rule_based_intent(self, question: str) -> Optional[IntentMatch]:
        q = question.lower().strip()
        category = self._extract_category_from_question(question)

        # TOTAL THIS MONTH
        if self._has_all(q, ["total", "month"]):
            return IntentMatch(intent=IntentType.TOTAL_THIS_MONTH)

        # CATEGORY SPEND (if we extracted a category)
        if category is not None:
            return IntentMatch(intent=IntentType.CATEGORY_SPEND, category=category)

        # TOP / MOST SPENT CATEGORY
        if (
            self._has_all(q, ["most", "category"])
            or self._has_all(q, ["top", "category"])
            or self._has_all(q, ["top", "spend"])
            or self._has_all(q, ["highest", "category"])
        ):
            return IntentMatch(intent=IntentType.TOP_CATEGORY)

        # OVER BUDGET
        if (
            self._has_all(q, ["exceed", "budget"])
            or self._has_all(q, ["over", "budget"])
            or self._has_all(q, ["above", "budget"])
            or self._has_all(q, ["cross", "budget"])
        ):
            return IntentMatch(intent=IntentType.OVER_BUDGET)

        # REMAINING BUDGET
        if self._has_all(q, ["remaining", "budget"]) or "left in my budget" in q:
            return IntentMatch(intent=IntentType.REMAINING_BUDGET)

        # LAST TRANSACTIONS
        if self._has_all(q, ["last", "transaction"]) or "recent transactions" in q:
            return IntentMatch(intent=IntentType.LAST_TRANSACTIONS)

        return None

    # --------------------------------------------------
    # SEMANTIC INTENT (Embeddings + FAISS)
    # --------------------------------------------------
    def _init_semantic_index(self) -> None:
        """
        Builds a tiny in-memory vector store of canonical phrasings
        for each supported intent.
        """
        # Embedding model (Ollama)
        self._embed = OllamaEmbeddings(
            model=self.embed_model,
            base_url=self.base_url,
        )

        docs: List[Document] = []

        # Canonical utterances for each intent
        examples: List[Tuple[IntentType, str]] = [
            # TOTAL_THIS_MONTH
            (IntentType.TOTAL_THIS_MONTH, "What is my total expense this month?"),
            (IntentType.TOTAL_THIS_MONTH, "How much did I spend this month?"),
            (IntentType.TOTAL_THIS_MONTH, "Total spending for this month"),

            # CATEGORY_SPEND
            (IntentType.CATEGORY_SPEND, "How much did I spend on Food & Dining?"),
            (IntentType.CATEGORY_SPEND, "Food spend"),
            (IntentType.CATEGORY_SPEND, "Groceries expense"),
            (IntentType.CATEGORY_SPEND, "How much on travel?"),

            # TOP_CATEGORY
            (IntentType.TOP_CATEGORY, "Which category did I spend the most on?"),
            (IntentType.TOP_CATEGORY, "Top spending category"),
            (IntentType.TOP_CATEGORY, "Where do I spend the highest amount?"),

            # OVER_BUDGET
            (IntentType.OVER_BUDGET, "Which category exceeded my budget?"),
            (IntentType.OVER_BUDGET, "Any category over budget?"),
            (IntentType.OVER_BUDGET, "Which budget did I cross?"),

            # REMAINING_BUDGET
            (IntentType.REMAINING_BUDGET, "What is my remaining budget?"),
            (IntentType.REMAINING_BUDGET, "How much budget is left?"),

            # LAST_TRANSACTIONS
            (IntentType.LAST_TRANSACTIONS, "Show my last 5 transactions."),
            (IntentType.LAST_TRANSACTIONS, "Recent transactions"),
            (IntentType.LAST_TRANSACTIONS, "Latest expenses list"),
        ]

        for intent, text in examples:
            docs.append(
                Document(
                    page_content=text,
                    metadata={"intent": intent.value},
                )
            )

        # Build FAISS vectorstore
        self._vectorstore = FAISS.from_documents(docs, self._embed)

    def _semantic_intent(self, question: str) -> Optional[IntentMatch]:
        """
        Use FAISS similarity search on the small canonical set.
        Lower score = closer match (L2 distance).
        """
        if not question.strip():
            return None

        try:
            results = self._vectorstore.similarity_search_with_score(
                question,
                k=1,
            )
        except Exception:
            # If embedding model / FAISS errors out, fail safely
            return None

        if not results:
            return None

        best_doc, score = results[0]

        # FAISS returns distance; lower is better
        if score > self.semantic_threshold:
            return None

        raw_intent = (best_doc.metadata or {}).get("intent")
        if not raw_intent:
            return None

        try:
            intent = IntentType(raw_intent)
        except ValueError:
            return None

        # For CATEGORY_SPEND, still try to extract category from the user question
        category = None
        if intent == IntentType.CATEGORY_SPEND:
            category = self._extract_category_from_question(question)

        return IntentMatch(intent=intent, category=category, score=score)

    # --------------------------------------------------
    # HELPERS
    # --------------------------------------------------
    @staticmethod
    def _has_all(q: str, words: List[str]) -> bool:
        q = q.lower()
        return all(w.lower() in q for w in words)

    @staticmethod
    def _extract_category_from_question(q: str) -> Optional[str]:
        """
        Examples:
          "How much did I spend on Food & Dining?"
          "Food spend"
          "Food spent"
        """
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
