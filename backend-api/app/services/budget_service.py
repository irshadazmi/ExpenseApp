from app.schemas.budget_schema import BudgetCreateSchema, BudgetUpdateSchema

class BudgetService:
    def __init__(self, budget_repository):
        self.budget_repository = budget_repository

    async def get_all_budgets(self, skip: int = 0, limit: int = 10):
        return await self.budget_repository.get_all_budgets(skip, limit)
    
    async def get_budget_by_id(self, budget_id: int):
        return await self.budget_repository.get_budget_by_id(budget_id)
    
    async def create_budget(self, budget: BudgetCreateSchema):
        budget_dict = budget.dict()
        return await self.budget_repository.create_budget(budget_dict)
    
    async def update_budget(self, budget_id: int, budget: BudgetUpdateSchema):
        budget_dict = budget.dict(exclude_unset=True)
        return self.budget_repository.update_budget(budget_id, budget_dict)
    
    async def delete_budget(self, budget_id: int):
        return await self.budget_repository.delete_budget(budget_id)