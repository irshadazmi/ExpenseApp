# backend-api/app/routers/dashboard_router.py

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db

from app.repositories.dashboard_repository import DashboardRepository
from app.repositories.budget_repository import BudgetRepository

from app.services.dashboard_service import DashboardService
from app.services.budget_service import BudgetService

dashboard_router = APIRouter()


# ============================================================
# Dependency (CORRECT)
# ============================================================
def get_dashboard_service(
    db: AsyncSession = Depends(get_db),
) -> DashboardService:
    dashboard_repo = DashboardRepository(db)
    budget_repo = BudgetRepository(db)
    budget_service = BudgetService(budget_repo)

    return DashboardService(
        repo=dashboard_repo,
        budget_service=budget_service,
    )


# ============================================================
# SUMMARY
# ============================================================
@dashboard_router.get("/summary")
async def summary(
    user_id: int = Query(..., description="User ID"),
    year: int | None = Query(None, description="Optional year filter"),
    month: int | None = Query(
        None,
        ge=1,
        le=12,
        description="Optional month filter (1–12)",
    ),
    service: DashboardService = Depends(get_dashboard_service),
):
    return await service.get_summary(
        user_id=user_id,
        year=year,
        month=month,
    )


# ============================================================
# CATEGORY REPORT
# ============================================================
@dashboard_router.get("/categories")
async def categories(
    user_id: int = Query(..., description="User ID"),
    year: int | None = Query(None, description="Optional year filter"),
    month: int | None = Query(None, ge=1, le=12),
    service: DashboardService = Depends(get_dashboard_service),
):
    return await service.get_category_report(
        user_id=user_id,
        year=year,
        month=month,
    )


# ============================================================
# RECENT TRANSACTIONS
# ============================================================
@dashboard_router.get("/recent")
async def recent_transactions(
    user_id: int = Query(..., description="User ID"),
    year: int | None = Query(None),
    month: int | None = Query(None, ge=1, le=12),
    limit: int = Query(10, ge=1, le=50),
    service: DashboardService = Depends(get_dashboard_service),
):
    return await service.get_recent_transactions(
        user_id=user_id,
        year=year,
        month=month,
        limit=limit,
    )


# ============================================================
# ACCOUNTS
# ============================================================
@dashboard_router.get("/accounts")
async def accounts(
    user_id: int = Query(...),
    service: DashboardService = Depends(get_dashboard_service),
):
    return await service.get_accounts(user_id)
