# app/repositories/ai_repository.py
from datetime import date
import json
from typing import List, Dict
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.schemas.ai_schema import AIInsight

class AIRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    # ============================================================
    # Generic raw SQL (LLM generated)
    # ============================================================
    async def run_sql(self, sql: str) -> List[Dict]:
        """
        Execute a SELECT SQL and return list of dict rows.
        Used only for LLM-generated SQL.
        """
        result = await self.db.execute(text(sql))
        rows = result.mappings().all()
        return [dict(r) for r in rows]

    # ============================================================
    # Categories (for auto-categorization)
    # ============================================================
    async def get_categories(self) -> List[Dict]:
        """
        Returns all active categories: id, name, short_name.
        """
        stmt = text(
            """
            SELECT id, name, short_name
            FROM categories
            WHERE is_active = TRUE
            ORDER BY id
            """
        )
        result = await self.db.execute(stmt)
        rows = result.mappings().all()
        return [dict(r) for r in rows]

    # ============================================================
    # FAQ QUERIES
    # ============================================================

    # -----------------------------
    # Total expense this month
    # -----------------------------
    async def get_total_expense_this_month(self, user_id: int) -> List[Dict]:
        """
        Total expense for the current month (per currency).
        """
        sql = text(
            """
            SELECT
                SUM(amount) AS sum,
                currency
            FROM transactions
            WHERE user_id = :user_id
              AND type = 'Expense'
              AND transaction_date >= date_trunc('month', CURRENT_DATE)
              AND transaction_date < date_trunc('month', CURRENT_DATE) + interval '1 month'
            GROUP BY currency;
            """
        )
        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Expense by category (fuzzy name)
    # -----------------------------
    async def get_expense_by_category(
        self,
        user_id: int,
        category_keyword: str,
    ) -> List[Dict]:
        """
        Sum of expenses where category name contains the given keyword.
        """
        sql = text(
            """
            SELECT
                SUM(t.amount) AS sum,
                t.currency
            FROM transactions t
            JOIN categories c ON t.category_id = c.id
            WHERE t.user_id = :user_id
              AND t.type = 'Expense'
              AND LOWER(c.name) LIKE '%' || LOWER(:kw) || '%'
            GROUP BY t.currency;
            """
        )
        params = {"user_id": user_id, "kw": category_keyword}
        result = await self.db.execute(sql, params)
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Most spent categories (top N)
    # -----------------------------
    async def get_top_categories(self, user_id: int, limit: int = 3) -> List[Dict]:
        """
        Top N categories by total expense.
        """
        sql = text(
            """
            SELECT
                c.name,
                SUM(t.amount) AS spent,
                t.currency
            FROM transactions t
            JOIN categories c ON t.category_id = c.id
            WHERE t.user_id = :user_id
              AND t.type = 'Expense'
            GROUP BY c.name, t.currency
            ORDER BY SUM(t.amount) DESC
            LIMIT :limit;
            """
        )
        result = await self.db.execute(sql, {"user_id": user_id, "limit": limit})
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Category usage vs budget (all categories)
    # -----------------------------
    async def get_category_usage(self, user_id: int) -> List[Dict]:
        """
        For each category: total spent vs budget.
        """
        sql = text(
            """
            SELECT
                c.name,
                SUM(t.amount) AS spent,
                b.amount AS budget,
                t.currency
            FROM categories c
            JOIN budgets b ON c.id = b.category_id
            JOIN transactions t ON c.id = t.category_id
            WHERE t.user_id = :user_id
              AND b.user_id = :user_id
              AND t.type = 'Expense'
            GROUP BY c.name, b.amount, t.currency;
            """
        )
        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Remaining budget (overall)
    # -----------------------------
    async def get_remaining_budget(self, user_id: int) -> List[Dict]:
        """
        Remaining budget per currency.
        """
        sql = text(
            """
            SELECT
              b.currency,
              SUM(b.amount) - (
                SELECT COALESCE(SUM(t.amount), 0)
                FROM transactions t
                WHERE t.user_id = :user_id
                  AND t.type = 'Expense'
              ) AS remaining
            FROM budgets b
            WHERE b.user_id = :user_id
            GROUP BY b.currency;
            """
        )
        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Last N transactions
    # -----------------------------
    async def get_last_transactions(self, user_id: int, limit: int = 5) -> List[Dict]:
        """
        Last N transactions for a user.
        """
        sql = text(
            """
            SELECT
              t.description,
              t.amount,
              t.currency,
              c.name AS category,
              t.type
            FROM transactions t
            JOIN categories c ON c.id = t.category_id
            WHERE t.user_id = :user_id
            ORDER BY t.transaction_date DESC
            LIMIT :limit;
            """
        )
        result = await self.db.execute(sql, {"user_id": user_id, "limit": limit})
        return [dict(r) for r in result.mappings().all()]

    # ============================================================
    # INSIGHTS QUERIES 
    # ============================================================

    # -----------------------------
    # Monthly Summary (for insights)
    # -----------------------------
    async def get_monthly_totals(self, user_id: int) -> List[Dict]:
        """
        Monthly totals for insights.
        NOTE: uses alias 'spent' (service converts if needed).
        """
        sql = text(
            """
            SELECT 
                COALESCE(SUM(amount), 0) AS spent,
                currency
            FROM transactions
            WHERE user_id = :user_id
              AND type = 'Expense'
              AND EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM CURRENT_DATE)
              AND EXTRACT(MONTH FROM transaction_date) = EXTRACT(MONTH FROM CURRENT_DATE)
            GROUP BY currency;
            """
        )

        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]
    
    # -----------------------------
    # Save monthly insights
    # -----------------------------
    async def save_monthly_insights(
        self,
        user_id: int,
        insights: List[AIInsight],
        insight_month: date,
    ):
        for i in insights:
            stmt = text("""
                INSERT INTO ai_insights (
                    user_id, insight_type, category_id,
                    title, message, severity, metadata,
                    confidence, insight_month
                )
                VALUES (
                    :user_id, :type, :category_id,
                    :title, :message, :severity, :metadata,
                    :confidence, :month
                )
                ON CONFLICT DO NOTHING
            """)
            await self.db.execute(stmt, {
                "user_id": user_id,
                "type": i.insight_type,
                "category_id": i.category_id,
                "title": i.title,
                "message": i.message,
                "severity": i.severity,
                "metadata": json.dumps(i.metadata),
                "confidence": i.confidence,
                "month": insight_month,
            })
        await self.db.commit()

