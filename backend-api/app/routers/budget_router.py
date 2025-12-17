# backend-api/app/routers/budget_router.py
from typing import Optional
from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.budget_repository import BudgetRepository
from app.schemas.budget_schema import (
    BudgetResponseSchema,
    BudgetCreateSchema,
    BudgetUpdateSchema,
    SaveAllBudgetsSchema,
)
from app.services.budget_service import BudgetService
from app.utils.exceptions import (
    FailedToUpdateException,
    InternalServerErrorException,
    RecordNotFoundException,
)

budget_router = APIRouter()


@budget_router.get("/", response_model=list[BudgetResponseSchema])
async def get_all_budgets(
    user_id: Optional[int] = None,
    session: AsyncSession = Depends(get_db),
):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.get_all_budgets(user_id)

@budget_router.get(
    "/by-month",
    response_model=Optional[BudgetResponseSchema],
)
async def get_budget_of_month(
    user_id: int,
    year: int,
    month: int,
    session: AsyncSession = Depends(get_db),
):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    try:
        return await budget_service.get_budget_of_month(user_id, year, month)
    except RecordNotFoundException:
        return None
    
@budget_router.get(
    "/total-amount",
    response_model=float,
)
async def get_total_budget_amount(
    user_id: int,
    year: int,
    month: int | None = None,
    session: AsyncSession = Depends(get_db),
):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.get_total_budget_amount(user_id, year, month) 

@budget_router.get("/{budget_id}", response_model=BudgetResponseSchema)
async def get_budget_by_id(budget_id: int, session: AsyncSession = Depends(get_db)):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.get_budget_by_id(budget_id)

@budget_router.post("/create-all-budgets", response_model=list[BudgetResponseSchema])
async def create_all_budgets(user_id: int, session: AsyncSession = Depends(get_db)):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.create_all_budgets(user_id)


@budget_router.post("/save-all-budgets", response_model=list[BudgetResponseSchema])
async def save_all_budgets(
    payload: SaveAllBudgetsSchema,  # ✅ BODY
    session: AsyncSession = Depends(get_db),
):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.save_all_budgets(payload)
