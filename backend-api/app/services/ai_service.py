from app.repositories.ai_repository import AIRepository
from app.schemas.ai_schema import *
from app.utils.llm_client import ask_llm

from app.services.dashboard_service import DashboardService
from app.repositories.dashboard_repository import DashboardRepository


SCHEMA_PROMPT = """
Database schema:

Tables:
- transactions(id, description, amount, type, category_id, account_id, user_id, transaction_date)
- categories(id, name)
- budgets(id, amount, user_id, category_id, effective_from, effective_to)

Rules:
- Only SELECT queries.
- Always filter by user_id.
- Return valid SQL only.
"""


class AIService:

    def __init__(self, repo: AIRepository, dashboard: DashboardService):
        self.repo = repo
        self.dashboard = dashboard

    # ============================================================
    # AI CHAT
    # ============================================================

    async def chat(self, user_id: int, question: str):

        prompt = f"""
{SCHEMA_PROMPT}

User ID = {user_id}

Question: {question}
"""

        sql = await ask_llm(prompt)

        rows = await self.repo.run_sql(sql)

        summary_prompt = f"""
Summarize the data below into 1-2 sentences.

Rows:
{rows}
"""

        answer = await ask_llm(summary_prompt)

        return {
            "answer": answer,
            "sql_used": sql,
            "rows": rows,
        }

    # ============================================================
    # AI INSIGHTS (Phase 2)
    # ============================================================

    async def insights(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
    ):

        data = await self.dashboard.get_summary(
            user_id=user_id,
            year=year,
            month=month,
        )

        insights = []

        # Budget overrun
        if data["burn_rate"]["risk"] == "over_budget":

            insights.append(
                {
                    "title": "Overspending Risk",
                    "severity": "high",
                    "message": "Your current spending rate may exceed your budget this month.",
                }
            )

        # Remaining money warning
        if data["totals"]["remaining"] < 0:
            insights.append(
                {
                    "title": "Budget Exceeded",
                    "severity": "high",
                    "message": f"You are ₹{abs(data['totals']['remaining'])} over budget.",
                }
            )

        # Healthy spending
        if data["burn_rate"]["risk"] == "under_budget":
            insights.append(
                {
                    "title": "Good Spending Control",
                    "severity": "low",
                    "message": "You are currently spending within your limits. Keep it up!",
                }
            )

        return insights

    # ============================================================
    # AUTO CATEGORY
    # ============================================================

    async def categorize(self, description: str):

        prompt = f"""
Map this transaction description to a category id:

Categories:
1 - Food & Dining
2 - Transportation
3 - Housing
4 - Healthcare
5 - Entertainment
6 - Travel
7 - Shopping
8 - Education
9 - Bills & Utilities
10 - Miscellaneous

Description: "{description}"

Return JSON:
{{ "category_id": number, "confidence": 0.01-1.0 }}
"""

        resp = await ask_llm(prompt)

        return AICategorizeResponse.parse_raw(resp)
