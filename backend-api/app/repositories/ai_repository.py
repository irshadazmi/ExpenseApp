from typing import List, Dict
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text


class AIRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    # ============================================================
    # Execute raw SQL (for LLM SQL)
    # ============================================================
    async def run_sql(self, sql: str) -> List[Dict]:
        """
        Execute a SELECT SQL and return list of dict rows.
        """
        result = await self.db.execute(text(sql))
        rows = result.mappings().all()
        return [dict(r) for r in rows]

    # ============================================================
    # Load categories (for auto-categorization)
    # ============================================================
    async def get_categories(self) -> List[Dict]:
        """
        Returns all active categories: id, name, short_name.
        """
        stmt = text("""
            SELECT id, name, short_name
            FROM categories
            WHERE is_active = TRUE
            ORDER BY id
        """)
        result = await self.db.execute(stmt)
        rows = result.mappings().all()
        return [dict(r) for r in rows]
    
    # -----------------------------
    # Monthly Summary
    # -----------------------------
    async def get_monthly_totals(self, user_id: int):
        sql = text("""
            SELECT 
                COALESCE(SUM(amount),0) AS spent,
                currency
            FROM transactions
            WHERE user_id=:user_id
              AND type='Expense'
              AND EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM CURRENT_DATE)
              AND EXTRACT(MONTH FROM transaction_date) = EXTRACT(MONTH FROM CURRENT_DATE)
            GROUP BY currency;
        """)

        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Category Usage
    # -----------------------------
    async def get_category_usage(self, user_id: int):
        sql = text("""
            SELECT
                c.name,
                SUM(t.amount) AS spent,
                b.amount AS budget,
                t.currency
            FROM categories c
            JOIN budgets b ON c.id=b.category_id
            JOIN transactions t ON c.id=t.category_id

            WHERE t.user_id=:user_id
              AND b.user_id=:user_id
              AND t.type='Expense'

            GROUP BY c.name,b.amount,t.currency;
        """)

        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]

    # -----------------------------
    # Most Spent Categories
    # -----------------------------
    async def get_top_categories(self, user_id: int):
        sql = text("""
            SELECT
                c.name,
                SUM(t.amount) AS spent,
                t.currency
            FROM transactions t
            JOIN categories c ON t.category_id=c.id

            WHERE t.user_id=:user_id
              AND t.type='Expense'

            GROUP BY c.name,t.currency
            ORDER BY SUM(t.amount) DESC
            LIMIT 3;
        """)

        result = await self.db.execute(sql, {"user_id": user_id})
        return [dict(r) for r in result.mappings().all()]

