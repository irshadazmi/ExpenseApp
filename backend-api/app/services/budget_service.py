# backend-api/app/services/budget_service.py
from datetime import datetime
from typing import Optional
from app.schemas.budget_schema import BudgetCreateSchema, BudgetUpdateSchema, SaveAllBudgetsSchema

class BudgetService:
    def __init__(self, budget_repository):
        self.budget_repository = budget_repository

    async def get_all_budgets(self, user_id: Optional[int] = None):
        return await self.budget_repository.get_all_budgets(user_id)
    
    async def get_budget_by_id(self, budget_id: int):
        return await self.budget_repository.get_budget_by_id(budget_id)
    
    async def get_budget_of_month(self, user_id: int, year: int, month: int):
        return await self.budget_repository.get_budget_of_month(
            user_id, year, month
        )
    
    async def get_total_budget_amount(self, user_id: int, year: int, month: int | None = None):
        return await self.budget_repository.get_total_budget_amount(user_id, year, month)
    
    async def create_all_budgets(self, user_id: int):
        return await self.budget_repository.create_all_budgets(user_id)

    async def save_all_budgets(self, payload: SaveAllBudgetsSchema):
        now = datetime.utcnow()
        latest_version = await self.budget_repository.get_latest_version(payload.user_id)
        version = (latest_version or 0) + 1

        saved_budgets = []

        for item in payload.budgets:
            update_schema = BudgetUpdateSchema(
                name=item.name,
                amount=item.amount,
                category_id=item.category_id,
                user_id=payload.user_id,
                currency="INR",
                period="Monthly",
                effective_from=None,
                effective_to=None,
                version=version,
                is_active=True,
                updated_at=now,
            )

            saved = await self.budget_repository.update_budget(
                item.id,          # ✅ ID PASSED HERE
                update_schema,
            )
            saved_budgets.append(saved)

        return saved_budgets



