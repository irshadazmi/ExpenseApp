from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text

class AIRepository:
    def __init__(self, db: AsyncSession):
        self.db = db


    # ============================================================
    # Execute raw SQL safely (for LLM SQL agent)
    # ============================================================
    async def run_sql(self, sql: str):

        result = await self.db.execute(text(sql))
        rows = result.mappings().all()

        return [dict(r) for r in rows]
