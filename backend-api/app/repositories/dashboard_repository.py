from datetime import datetime
from sqlalchemy import select, func, extract
from datetime import date, datetime
import calendar
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.transaction_model import TransactionModel
from app.models.category_model import CategoryModel
from app.models.account_model import AccountModel
from app.services.budget_service import BudgetService
from app.repositories.budget_repository import BudgetRepository


class DashboardRepository:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.budget_service = BudgetService(BudgetRepository(db))

    # ============================================================
    # Helpers
    # ============================================================

    def _normalize_period(self, year: int | None, month: int | None):
        today = date.today()

        if year is None and month is None:
            return today.year, today.month, True

        if year is not None and month is None:
            return year, None, False

        if year is None and month is not None:
            return today.year, month, True

        return year, month, True

    def _apply_period_filter(self, stmt, date_column, year, month):
        if year is not None:
            stmt = stmt.where(extract("year", date_column) == year)
        if month is not None:
            stmt = stmt.where(extract("month", date_column) == month)
        return stmt

    # ============================================================
    # SUMMARY  ✅ FIXED
    # ============================================================

    async def get_summary(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
    ):
        from datetime import datetime
        import calendar

        now = datetime.utcnow()

        # --------------------------------------------------
        # 1️⃣ Resolve period
        # --------------------------------------------------
        period_year = year or now.year
        period_month = month

        # --------------------------------------------------
        # 2️⃣ Period metadata
        # --------------------------------------------------
        if period_month:
            target_month = datetime(period_year, period_month, 1)

            days_in_period = calendar.monthrange(period_year, period_month)[1]
            days_elapsed = (
                min(now.day, days_in_period)
                if period_year == now.year and period_month == now.month
                else days_in_period
            )
        else:
            target_year = period_year
            days_in_period = 366 if calendar.isleap(target_year) else 365
            days_elapsed = (
                now.timetuple().tm_yday if target_year == now.year else days_in_period
            )

        # --------------------------------------------------
        # 3️⃣ Expenses (✅ FIXED)
        # --------------------------------------------------
        spent = await self.db.scalar(
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(TransactionModel.user_id == user_id)
            .where(TransactionModel.type == "Expense")
            .where(
                func.date_trunc(
                    "month",
                    TransactionModel.transaction_date,
                )
                == datetime(period_year, period_month or 1, 1)
                if period_month
                else func.date_trunc("year", TransactionModel.transaction_date)
                == datetime(period_year, 1, 1)
            )
        )

        # --------------------------------------------------
        # 4️⃣ Income (✅ FIXED)
        # --------------------------------------------------
        earning = await self.db.scalar(
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(TransactionModel.user_id == user_id)
            .where(TransactionModel.type == "Income")
            .where(
                func.date_trunc(
                    "month",
                    TransactionModel.transaction_date,
                )
                == datetime(period_year, period_month or 1, 1)
                if period_month
                else func.date_trunc("year", TransactionModel.transaction_date)
                == datetime(period_year, 1, 1)
            )
        )

        # --------------------------------------------------
        # 5️⃣ Budget (injected later by service)
        # --------------------------------------------------
        total_budget = 0

        remaining = total_budget - spent
        usage_percent = (spent / total_budget * 100) if total_budget > 0 else 0

        return {
            "totals": {
                "budget": total_budget,
                "spent": float(spent),
                "earning": float(earning),
                "remaining": float(remaining),
                "usage_percent": round(usage_percent, 2),
            },
            "burn_rate": {
                "daily_budget": total_budget / days_in_period if total_budget else 0,
                "daily_spend": spent / max(days_elapsed, 1),
                "risk": "over_budget" if spent > total_budget else "under_budget",
            },
            "period": {
                "year": period_year,
                "month": period_month,
                "days_elapsed": days_elapsed,
                "days_in_period": days_in_period,
            },
        }

    # ============================================================
    # CATEGORY REPORT (Already mostly correct)
    # ============================================================

    async def get_category_report(self, user_id: int, year=None, month=None):
        norm_year, norm_month, use_month = self._normalize_period(year, month)

        stmt = (
            select(
                CategoryModel.id,
                CategoryModel.name,
                CategoryModel.short_name,
                func.coalesce(func.sum(TransactionModel.amount), 0).label("spent"),
            )
            .select_from(CategoryModel)
            .join(TransactionModel, TransactionModel.category_id == CategoryModel.id, isouter=True)
            .where(TransactionModel.user_id == user_id)
            .where(TransactionModel.type == "Expense")
            .group_by(CategoryModel.id, CategoryModel.name, CategoryModel.short_name)
            .order_by(CategoryModel.name)
        )

        stmt = self._apply_period_filter(
            stmt,
            TransactionModel.transaction_date,
            norm_year,
            norm_month if use_month else None,
        )

        result = await self.db.execute(stmt)

        return [
            {
                "category_id": r.id,
                "category_name": r.name,
                "short_name": r.short_name,
                "spent": float(r.spent or 0),
            }
            for r in result
        ]

    # ============================================================
    # RECENT TRANSACTIONS (unchanged)
    # ============================================================

    async def get_recent_transactions(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
        limit: int = 10,
    ):
        stmt = (
            select(TransactionModel)
            .where(TransactionModel.user_id == user_id)
            .order_by(TransactionModel.transaction_date.desc())
            .limit(limit)
        )

        result = await self.db.execute(stmt)
        txns = result.scalars().all()

        return [
            {
                "id": t.id,
                "description": t.description,
                "amount": t.amount,
                "type": t.type,
                "category": None,  # fill later if needed
                "transaction_date": t.transaction_date,
            }
            for t in txns
        ]

