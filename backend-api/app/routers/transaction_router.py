# backend-api/app/routers/transaction_router.py
from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.transaction_repository import TransactionRepository
from app.schemas.transaction_schema import (
    CategoryTransactionSummary,
    TransactionCreateSchema,
    TransactionResponseSchema,
    TransactionUpdateSchema,
)
from app.services.transaction_service import TransactionService

transaction_router = APIRouter()

@transaction_router.get("/grouped-by-category")
async def get_transactions_grouped_by_category(session: AsyncSession = Depends(get_db)):
    repo = TransactionRepository(session)
    service = TransactionService(repo)
    return await service.get_transactions_grouped_by_category()

@transaction_router.get("/summary-by-category", response_model=list[CategoryTransactionSummary])
async def get_category_wise_totals(session: AsyncSession = Depends(get_db)):
    repo = TransactionRepository(session)
    service = TransactionService(repo)
    return await service.get_category_wise_totals()

@transaction_router.get("/", response_model=list[TransactionResponseSchema])
async def get_all_transactions(
    user_id: Optional[int] = None, 
    session: AsyncSession = Depends(get_db),
):
    transaction_repo = TransactionRepository(session)
    transaction_service = TransactionService(transaction_repo)
    return await transaction_service.get_all_transactions(user_id)

@transaction_router.get("/{transaction_id}", response_model=TransactionResponseSchema)
async def get_transaction_by_id(transaction_id: int, session: AsyncSession = Depends(get_db)):
    transaction_repo = TransactionRepository(session)
    transaction_service = TransactionService(transaction_repo)
    return await transaction_service.get_transaction_by_id(transaction_id)


@transaction_router.post("/", response_model=TransactionResponseSchema)
async def create_transaction(
    transaction: TransactionCreateSchema, session: AsyncSession = Depends(get_db)
):
    transaction_repo = TransactionRepository(session)
    transaction_service = TransactionService(transaction_repo)
    return await transaction_service.create_transaction(transaction)


@transaction_router.put("/{transaction_id}", response_model=TransactionResponseSchema)
async def update_transaction(
    transaction_id: int,
    transaction_data: TransactionUpdateSchema,
    session: AsyncSession = Depends(get_db),
):
    transaction_repo = TransactionRepository(session)
    transaction_service = TransactionService(transaction_repo)
    return await transaction_service.update_transaction(transaction_id, transaction_data)


@transaction_router.delete("/{transaction_id}")
async def delete_transaction(transaction_id: int, session: AsyncSession = Depends(get_db)):
    transaction_repo = TransactionRepository(session)
    transaction_service = TransactionService(transaction_repo)
    await transaction_service.delete_transaction(transaction_id)
    return {"detail": "Transaction deleted successfully"}
