# app/services/dashboard_service.py
from datetime import datetime
from app.repositories.dashboard_repository import DashboardRepository
from app.services.budget_service import BudgetService


class DashboardService:
    def __init__(
        self,
        repo: DashboardRepository,
        budget_service: BudgetService,
    ):
        self.repo = repo
        self.budget_service = budget_service

    # ============================================================
    # SUMMARY
    # ============================================================
    async def get_summary(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
    ):
        """
        Returns:
        - Monthly summary when year+month provided
        - Yearly summary when only year provided
        - Defaults to current month
        """

        # --------------------------------------------------
        # 1️⃣ Resolve defaults CORRECTLY
        # --------------------------------------------------
        now = datetime.utcnow()

        if year is None and month is None:
            # default = current month
            year = now.year
            month = now.month

        # IMPORTANT:
        # - If year is provided and month is None → YEARLY
        # - Do NOT auto-fill month

        # --------------------------------------------------
        # 2️⃣ Base summary (spend / income / dates)
        # --------------------------------------------------
        summary = await self.repo.get_summary(
            user_id=user_id,
            year=year,
            month=month,
        )

        # --------------------------------------------------
        # 3️⃣ Inject TOTAL BUDGET (business logic)
        # --------------------------------------------------
        if month is not None:
            # Monthly budget
            total_budget = await self.budget_service.get_budget_of_month(
                user_id=user_id,
                year=year,
                month=month,
            )
            summary["totals"]["budget"] = float(total_budget.amount)
        else:
            # Yearly total = sum of all valid monthly budgets
            summary["totals"]["budget"] = await self.budget_service.get_total_budget_amount(
                user_id=user_id,
                year=year,
            )

        # --------------------------------------------------
        # 4️⃣ Recalculate derived values
        # --------------------------------------------------
        spent = summary["totals"].get("spent", 0) or 0
        budget = summary["totals"].get("budget", 0) or 0

        summary["totals"]["remaining"] = max(budget - spent, 0)
        summary["totals"]["usage_percent"] = (
            (spent / budget) * 100 if budget > 0 else 0
        )

        return summary

    # ============================================================
    # CATEGORY REPORT
    # ============================================================
    async def get_category_report(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
    ):
        return await self.repo.get_category_report(
            user_id=user_id,
            year=year,
            month=month,
        )

    # ============================================================
    # RECENT TRANSACTIONS
    # ============================================================
    async def get_recent_transactions(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
        limit: int = 10,
    ):
        return await self.repo.get_recent_transactions(
            user_id=user_id,
            year=year,
            month=month,
            limit=limit,
        )

    # ============================================================
    # ACCOUNTS
    # ============================================================
    async def get_accounts(self, user_id: int):
        return await self.repo.get_accounts(user_id)
