from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.expense_repository import ExpenseRepository
from app.schemas.expense_schema import (
    CategoryExpenseSummary,
    ExpenseCreateSchema,
    ExpenseResponseSchema,
    ExpenseUpdateSchema,
)
from app.services.expense_service import ExpenseService

expense_router = APIRouter()

@expense_router.get("/grouped-by-category")
async def get_expenses_grouped_by_category(db: AsyncSession = Depends(get_db)):
    repo = ExpenseRepository(db)
    service = ExpenseService(repo)
    return await service.get_expenses_grouped_by_category()

@expense_router.get("/summary-by-category", response_model=list[CategoryExpenseSummary])
async def get_category_wise_totals(db: AsyncSession = Depends(get_db)):
    repo = ExpenseRepository(db)
    service = ExpenseService(repo)
    return await service.get_category_wise_totals()

@expense_router.get("/", response_model=list[ExpenseResponseSchema])
async def get_all_expenses(
    skip: int = 0, limit: int = 10, db: AsyncSession = Depends(get_db)
):
    expense_repo = ExpenseRepository(db)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.get_all_expenses(skip, limit)


@expense_router.get("/{expense_id}", response_model=ExpenseResponseSchema)
async def get_expense_by_id(expense_id: int, db: AsyncSession = Depends(get_db)):
    expense_repo = ExpenseRepository(db)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.get_expense_by_id(expense_id)


@expense_router.post("/", response_model=ExpenseResponseSchema)
async def create_expense(
    expense: ExpenseCreateSchema, db: AsyncSession = Depends(get_db)
):
    expense_repo = ExpenseRepository(db)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.create_expense(expense)


@expense_router.put("/{expense_id}", response_model=ExpenseResponseSchema)
async def update_expense(
    expense_id: int,
    expense_data: ExpenseUpdateSchema,
    db: AsyncSession = Depends(get_db),
):
    expense_repo = ExpenseRepository(db)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.update_expense(expense_id, expense_data)


@expense_router.delete("/{expense_id}")
async def delete_expense(expense_id: int, db: AsyncSession = Depends(get_db)):
    expense_repo = ExpenseRepository(db)
    expense_service = ExpenseService(expense_repo)
    await expense_service.delete_expense(expense_id)
    return {"detail": "Expense deleted successfully"}
