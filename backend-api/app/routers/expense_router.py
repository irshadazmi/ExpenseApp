from typing import Optional
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
async def get_expenses_grouped_by_category(session: AsyncSession = Depends(get_db)):
    repo = ExpenseRepository(session)
    service = ExpenseService(repo)
    return await service.get_expenses_grouped_by_category()

@expense_router.get("/summary-by-category", response_model=list[CategoryExpenseSummary])
async def get_category_wise_totals(session: AsyncSession = Depends(get_db)):
    repo = ExpenseRepository(session)
    service = ExpenseService(repo)
    return await service.get_category_wise_totals()

@expense_router.get("/", response_model=list[ExpenseResponseSchema])
async def get_all_expenses(
    user_id: Optional[int] = None, 
    session: AsyncSession = Depends(get_db),
):
    expense_repo = ExpenseRepository(session)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.get_all_expenses(user_id)

@expense_router.get("/{expense_id}", response_model=ExpenseResponseSchema)
async def get_expense_by_id(expense_id: int, session: AsyncSession = Depends(get_db)):
    expense_repo = ExpenseRepository(session)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.get_expense_by_id(expense_id)


@expense_router.post("/", response_model=ExpenseResponseSchema)
async def create_expense(
    expense: ExpenseCreateSchema, session: AsyncSession = Depends(get_db)
):
    expense_repo = ExpenseRepository(session)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.create_expense(expense)


@expense_router.put("/{expense_id}", response_model=ExpenseResponseSchema)
async def update_expense(
    expense_id: int,
    expense_data: ExpenseUpdateSchema,
    session: AsyncSession = Depends(get_db),
):
    expense_repo = ExpenseRepository(session)
    expense_service = ExpenseService(expense_repo)
    return await expense_service.update_expense(expense_id, expense_data)


@expense_router.delete("/{expense_id}")
async def delete_expense(expense_id: int, session: AsyncSession = Depends(get_db)):
    expense_repo = ExpenseRepository(session)
    expense_service = ExpenseService(expense_repo)
    await expense_service.delete_expense(expense_id)
    return {"detail": "Expense deleted successfully"}
