# backend-api/app/services/dashboard_service.py
from app.repositories.dashboard_repository import DashboardRepository

class DashboardService:
    def __init__(self, repo: DashboardRepository):
        self.repo = repo

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
        return await self.repo.get_summary(
            user_id=user_id,
            year=year,
            month=month,
        )

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
