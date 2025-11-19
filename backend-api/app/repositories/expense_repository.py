from sqlalchemy import func, select
from sqlalchemy.orm import selectinload
from app.models.category_model import CategoryModel
from app.models.expense_model import ExpenseModel
from app.schemas.expense_schema import ExpenseCreateSchema, ExpenseUpdateSchema
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)


class ExpenseRepository:
    def __init__(self, db):
        self.db = db

    async def get_expenses_grouped_by_category(self):
        stmt = (
            select(
                ExpenseModel.id,
                ExpenseModel.description,
                ExpenseModel.amount,
                ExpenseModel.expense_date,
                CategoryModel.name.label("category_name")
            )
            .join(CategoryModel, CategoryModel.id == ExpenseModel.category_id)
            .order_by(CategoryModel.name, ExpenseModel.expense_date)
        )
        result = await self.db.execute(stmt)
        rows = result.all()

        grouped = {}
        for row in rows:
            category = row.category_name
            if category not in grouped:
                grouped[category] = []
            grouped[category].append({
                "id": row.id,
                "description": row.description,
                "amount": float(row.amount),
                "date": row.expense_date.strftime("%Y-%m-%d")
            })

        return [{"title": category, "data": expenses} for category, expenses in grouped.items()]

    async def get_category_wise_totals(self):
        stmt = (
            select(
                ExpenseModel.category_id,
                CategoryModel.name.label("category_name"),
                func.sum(ExpenseModel.amount).label("total_amount")
            )
            .join(CategoryModel, CategoryModel.id == ExpenseModel.category_id)
            .group_by(ExpenseModel.category_id, CategoryModel.name)
        )
        result = await self.db.execute(stmt)
        return result.all()

    async def get_all_expenses(self, skip: int = 0, limit: int = 10):
        result = await self.db.execute(select(ExpenseModel).offset(skip).limit(limit))
        if not result:
            raise RecordNotFoundException("No expense records found")
        return result.scalars().all()

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

    async def update_expense(self, expense_id: int, expense_data: ExpenseUpdateSchema) -> ExpenseModel:
        result = await self.db.execute(
            select(ExpenseModel).where(ExpenseModel.id == expense_id)
        )
        expense = result.scalars().first()

        if not expense:
            raise RecordNotFoundException("Expense not found")

        update_data = expense_data.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(expense, key, value)

        try:
            self.db.add(expense)
            await self.db.commit()
            await self.db.refresh(expense)
            return expense
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
            await self.db.delete(expense)
            await self.db.commit()
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
