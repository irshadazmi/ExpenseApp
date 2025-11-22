from datetime import datetime
from typing import Optional
from sqlalchemy import select
from app.schemas.expense_schema import ExpenseCreateSchema, ExpenseUpdateSchema
from app.models.expense_model import ExpenseModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)

class ExpenseRepository:
    def __init__(self, db):
        self.db = db

    async def get_all_expenses(self, user_id: Optional[int] = None):
        stmt = select(ExpenseModel)

        if user_id is not None:
            stmt = stmt.where(ExpenseModel.user_id == user_id)

        result = await self.db.execute(stmt)
        rows = result.scalars().all()

        if not rows:
            return []

        return rows

    async def get_expense_by_id(self, expense_id: int):
        result = await self.db.execute(
            select(ExpenseModel).where(ExpenseModel.id == expense_id)
        )
        expense = result.scalars().first()
        if not expense:
            raise RecordNotFoundException("Expense not found")
        return expense

    async def create_expense(self, expense: ExpenseCreateSchema) -> ExpenseModel:
        db_expense = ExpenseModel(**expense.dict(exclude_unset=True))

        try:
            self.db.add(db_expense)
            await self.db.commit()
            await self.db.refresh(db_expense)
            return db_expense
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_expense(self, expense_id: int, expense_data: dict):
        result = await self.db.execute(select(ExpenseModel).where(ExpenseModel.id == expense_id))
        existing_expense = result.scalars().first()

        if not existing_expense:
            raise RecordNotFoundException("Expense not found")

        # update_data = expense_data.dict(exclude_unset=True)
        for key, value in expense_data.items():
            setattr(existing_expense, key, value)

        try:
            existing_expense.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(existing_expense)
            return existing_expense
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_expense(self, expense_id: int):
        result = await self.db.execute(
            select(ExpenseModel).where(ExpenseModel.id == expense_id)
        )
        expense = result.scalars().first()
        if not expense:
            raise RecordNotFoundException("Expense not found")

        try:
            expense.is_active = False
            expense.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(expense)
            return expense
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
