# app/routers/seed_router.py
from datetime import datetime
from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.seed.faker_seed import seed_budgets, seed_transactions

seed_router = APIRouter()

# @seed_router.post("/")
# async def run_seed(db: AsyncSession = Depends(get_db)):
#     await seed_categories(db)
#     await seed_users(db)
#     await seed_accounts(db)
#     await seed_budgets(db)
#     await seed_transactions(db)
#     return {"detail": "Database seeded successfully!"}


@seed_router.post("/budgets")
async def seed_budgets_api(
    db: AsyncSession = Depends(get_db), effective_from: Optional[datetime] = None
):
    await seed_budgets(db, effective_from)
    return {"detail": "Budgets seeded successfully!"}


@seed_router.post("/transactions")
async def seed_transactions_api(
    db: AsyncSession = Depends(get_db),
    effective_from: Optional[datetime] = None,
    effective_to: Optional[datetime] = None,
    total_num_txns: Optional[int] = None,
):
    await seed_transactions(db, effective_from, effective_to, total_num_txns)
    return {"detail": "Transactions seeded successfully!"}
