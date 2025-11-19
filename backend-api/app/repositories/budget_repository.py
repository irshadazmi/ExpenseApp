from datetime import datetime
from typing import Optional
from sqlalchemy import select
from app.schemas.budget_schema import BudgetResponseSchema
from app.models.budget_model import BudgetModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)

class BudgetRepository:
    def __init__(self, db):
        self.db = db

    async def get_all_budgets(self, user_id: Optional[int] = None):
        stmt = select(BudgetModel)

        if user_id is not None:
            stmt = stmt.where(BudgetModel.user_id == user_id)

        result = await self.db.execute(stmt)
        rows = result.scalars().all()

        if not rows:
            return []

        return rows

    async def get_budget_by_id(self, budget_id: int):
        result = await self.db.execute(
            select(BudgetModel).where(BudgetModel.id == budget_id)
        )
        budget = result.scalars().first()
        if not budget:
            raise RecordNotFoundException("Budget not found")
        return budget

    async def create_budget(self, budget: BudgetResponseSchema) -> BudgetModel:
        db_budget = BudgetModel(**budget.dict(exclude_unset=True))

        try:
            self.db.add(db_budget)
            await self.db.commit()
            await self.db.refresh(db_budget)
            return db_budget
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_budget(
        self, budget_id: int, budget_data: BudgetResponseSchema
    ) -> BudgetModel:
        result = await self.db.execute(
            select(BudgetModel).where(BudgetModel.id == budget_id)
        )
        budget = result.scalars().first()

        if not budget:
            raise RecordNotFoundException("Budget not found")

        update_data = budget_data.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(budget, key, value)

        try:
            budget.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(budget)
            return budget
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_budget(self, budget_id: int):
        result = await self.db.execute(
            select(BudgetModel).where(BudgetModel.id == budget_id)
        )
        budget = result.scalars().first()
        if not budget:
            raise RecordNotFoundException("Budget not found")

        try:
            budget.is_active = False
            budget.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(budget)
            return budget
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
