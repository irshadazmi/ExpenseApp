from app.repositories.dashboard_repository import DashboardRepository

class DashboardService:
    def __init__(self, repo: DashboardRepository):
        self.repo = repo

    async def get_summary(self, user_id: int):
        return await self.repo.get_summary(user_id)

    async def get_category_report(self, user_id: int):
        return await self.repo.get_category_report(user_id)

    async def get_recent_transactions(self, user_id: int):
        return await self.repo.get_recent_transactions(user_id)

    async def get_accounts(self, user_id: int):
        return await self.repo.get_accounts(user_id)
