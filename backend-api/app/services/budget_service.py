from typing import Optional
from app.schemas.budget_schema import BudgetCreateSchema, BudgetUpdateSchema
from app.utils.exceptions import FailedToUpdateException

class BudgetService:
    def __init__(self, budget_repository):
        self.budget_repository = budget_repository

    async def get_all_budgets(self, user_id: Optional[int] = None):
        return await self.budget_repository.get_all_budgets(user_id)
    
    async def get_budget_by_id(self, budget_id: int):
        return await self.budget_repository.get_budget_by_id(budget_id)
    
    async def create_budget(self, budget_data: BudgetCreateSchema):
        if budget_data.balance < 0:
            raise FailedToUpdateException(detail="Amount cannot be negative")
        
        budget_dict = budget_data.model_dump()
        return await self.budget_repository.create_budget(budget_dict)
    
    async def update_budget(self, budget_id: int, budget_data: BudgetUpdateSchema):
        if budget_data.amount < 0:
            raise FailedToUpdateException(detail="Amount cannot be negative")

        budget_dict = budget_data.model_dump(exclude_unset=True)
        return await self.budget_repository.update_budget(budget_id, budget_dict)
    
    async def delete_budget(self, budget_id: int):
        return await self.budget_repository.delete_budget(budget_id)