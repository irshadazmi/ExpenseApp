from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.budget_repository import BudgetRepository
from app.schemas.budget_schema import BudgetResponseSchema
from app.services.budget_service import BudgetService
from app.utils.exceptions import InternalServerErrorException, RecordNotFoundException

budget_router = APIRouter()

@budget_router.get("/", response_model=list[BudgetResponseSchema])
async def get_all_accounts(
    user_id: Optional[int] = None, 
    session: AsyncSession = Depends(get_db),
):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.get_all_budgets(user_id)
    
@budget_router.get("/{budget_id}", response_model=BudgetResponseSchema)
async def get_budget_by_id(budget_id: int, session: AsyncSession = Depends(get_db)):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    
    try:
        return await budget_service.get_budget_by_id(budget_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get budget "+str(e))
    
@budget_router.post("/", response_model=BudgetResponseSchema)
async def create_budget(budget: BudgetResponseSchema, session: AsyncSession = Depends(get_db)):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.create_budget(budget)
    
@budget_router.put("/{budget_id}", response_model=BudgetResponseSchema)
async def update_budget(budget_id: int, budget: BudgetResponseSchema, session: AsyncSession = Depends(get_db)):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.update_budget(budget_id, budget)
    
@budget_router.delete("/{budget_id}")
async def delete_budget(budget_id: int, session: AsyncSession = Depends(get_db)):
    budget_repo = BudgetRepository(session)
    budget_service = BudgetService(budget_repo)
    return await budget_service.delete_budget(budget_id)