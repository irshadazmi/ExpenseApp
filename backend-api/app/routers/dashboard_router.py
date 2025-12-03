from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.repositories.dashboard_repository import DashboardRepository
from app.services.dashboard_service import DashboardService

dashboard_router = APIRouter()

@dashboard_router.get("/summary")
async def summary(user_id: int, db: AsyncSession = Depends(get_db)):
    return await DashboardService(DashboardRepository(db)).get_summary(user_id)

@dashboard_router.get("/categories")
async def categories(user_id: int, db: AsyncSession = Depends(get_db)):
    return await DashboardService(DashboardRepository(db)).get_category_report(user_id)

@dashboard_router.get("/recent")
async def recent(user_id: int, db: AsyncSession = Depends(get_db)):
    return await DashboardService(DashboardRepository(db)).get_recent_transactions(user_id)

@dashboard_router.get("/accounts")
async def accounts(user_id: int, db: AsyncSession = Depends(get_db)):
    return await DashboardService(DashboardRepository(db)).get_accounts(user_id)
