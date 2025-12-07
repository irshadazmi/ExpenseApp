# backend-api/app/repositories/dashboard_repository.py
from sqlalchemy import select, func, extract
from datetime import date
import calendar
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.transaction_model import TransactionModel
from app.models.budget_model import BudgetModel
from app.models.category_model import CategoryModel
from app.models.account_model import AccountModel


class DashboardRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    # ============================================================
    # Helper – Normalize period (year / month semantics)
    # ============================================================
    def _normalize_period(self, year: int | None, month: int | None):
        """
        Returns (norm_year, norm_month, use_month)

        Rules:
        - year=None, month=None       -> current year, current month (monthly view)
        - year!=None, month=None      -> given year, full year view (month=None)
        - year!=None, month!=None     -> given year + given month (monthly view)
        - year=None, month!=None      -> current year + given month (monthly view)
        """
        today = date.today()

        # No year & no month -> current month
        if year is None and month is None:
            return today.year, today.month, True

        # Year only -> full year
        if year is not None and month is None:
            return year, None, False

        # Month only (rare, but support it) -> current year, that month
        if year is None and month is not None:
            return today.year, month, True

        # Both provided
        return year, month, True

    # ============================================================
    # Helper – Apply Period Filters on a date column
    # ============================================================
    def _apply_period_filter(self, stmt, date_column, year: int | None, month: int | None):
        if year is not None:
            stmt = stmt.where(extract("year", date_column) == year)

        if year is not None and month is not None:
            stmt = stmt.where(extract("month", date_column) == month)

        return stmt

    # ============================================================
    # SUMMARY
    # ============================================================
    async def get_summary(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
    ):
        """
        Business rules:
        - Budgets are versioned.
        - Exactly ONE budget is active at any point in time
            (effective_from <= date <= effective_to OR effective_to IS NULL)

        Behavior:
        - no year & no month   => current month (single active budget)
        - year + month        => month view (single budget active in that month)
        - year only           => yearly view (sum active budget for each month)
        """

        print("Dahboard repo - Year:", year, "Month:", month)

        norm_year, norm_month, use_month = self._normalize_period(year, month)
        today = date.today()

        # ==================================================================
        # ----------- BUDGET CALCULATION ----------------------------------
        # ==================================================================

        async def _get_monthly_budget(target_date: date) -> float:
            """Return the SINGLE budget active on a given date."""

            stmt = (
                select(func.coalesce(func.sum(BudgetModel.amount), 0))
                .where(
                    BudgetModel.user_id == user_id,
                    BudgetModel.effective_from <= target_date,
                    func.coalesce(BudgetModel.effective_to, target_date) >= target_date,
                )
            )

            return (await self.db.execute(stmt)).scalar() or 0

        # ----------------------------------------------------------
        # Monthly view
        # ----------------------------------------------------------
        if use_month and norm_month:

            target_date = date(norm_year, norm_month, 15)  # any day in month works
            total_budget = await _get_monthly_budget(target_date)

            days_in_period = calendar.monthrange(norm_year, norm_month)[1]

            if norm_year == today.year and norm_month == today.month:
                days_elapsed = min(today.day, days_in_period)
            else:
                days_elapsed = days_in_period

        # ----------------------------------------------------------
        # Yearly view
        # ----------------------------------------------------------
        else:
            total_budget = 0
            days_in_period = 366 if calendar.isleap(norm_year) else 365

            for m in range(1, 13):
                month_date = date(norm_year, m, 15)
                month_budget = await _get_monthly_budget(month_date)
                total_budget += month_budget

            if norm_year == today.year:
                days_elapsed = today.timetuple().tm_yday
            else:
                days_elapsed = days_in_period

        # ==================================================================
        # ---------------- TRANSACTION TOTALS ------------------------------
        # ==================================================================

        stmt_spent = (
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(
                TransactionModel.user_id == user_id,
                TransactionModel.type == "Expense",
            )
        )

        stmt_spent = self._apply_period_filter(
            stmt_spent,
            TransactionModel.transaction_date,
            norm_year,
            norm_month if use_month else None,
        )

        total_spent = (await self.db.execute(stmt_spent)).scalar() or 0

        # ----------------------------------------------------------

        stmt_earning = (
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(
                TransactionModel.user_id == user_id,
                TransactionModel.type == "Income",
            )
        )

        stmt_earning = self._apply_period_filter(
            stmt_earning,
            TransactionModel.transaction_date,
            norm_year,
            norm_month if use_month else None,
        )

        total_earning = (await self.db.execute(stmt_earning)).scalar() or 0

        # ==================================================================
        # ---------------- KPI CALCULATIONS --------------------------------
        # ==================================================================

        remaining = total_budget - total_spent

        usage_percent = round(
            (total_spent / total_budget) * 100, 2
        ) if total_budget else 0

        daily_budget = total_budget / days_in_period if total_budget else 0
        daily_spend = total_spent / max(days_elapsed, 1)

        if daily_spend > daily_budget:
            risk = "over_budget"
        elif daily_spend >= daily_budget * 0.9:
            risk = "on_track"
        else:
            risk = "under_budget"

        # ==================================================================
        # ---------------- RESPONSE ----------------------------------------
        # ==================================================================

        return {
            "totals": {
                "budget": round(total_budget, 2),
                "spent": round(total_spent, 2),
                "earning": round(total_earning, 2),
                "remaining": round(remaining, 2),
                "usage_percent": usage_percent,
            },
            "burn_rate": {
                "daily_budget": round(daily_budget, 2),
                "daily_spend": round(daily_spend, 2),
                "risk": risk,
            },
            "period": {
                "year": norm_year,
                "month": norm_month if use_month else None,
                "days_elapsed": days_elapsed,
                "days_in_period": days_in_period,
            },
        }

    # ============================================================
    # CATEGORY REPORT  ✅ FIXED
    # ============================================================

    async def get_category_report(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
    ):

        norm_year, norm_month, use_month = self._normalize_period(year, month)
        today = date.today()

        # ----------------------------------------------------------
        # Resolve target period start date
        # ----------------------------------------------------------

        if use_month and norm_month is not None:
            # Single month view
            period_start = date(norm_year, norm_month, 1)
            period_end = None  # handled by effective_to
        else:
            # Year view → take Jan 1
            period_start = date(norm_year, 1, 1)
            period_end = date(norm_year, 12, 31)

        # ----------------------------------------------------------
        # Base statement
        # ----------------------------------------------------------

        stmt = (
            select(
                CategoryModel.id.label("category_id"),
                CategoryModel.name.label("category_name"),
                CategoryModel.short_name.label("short_name"),
                func.coalesce(func.sum(BudgetModel.amount), 0).label("budget"),
                func.coalesce(func.sum(TransactionModel.amount), 0).label("spent"),
            )
            .select_from(CategoryModel)

            # Join ACTIVE budget rows
            .join(
                BudgetModel,
                (BudgetModel.category_id == CategoryModel.id)
                & (BudgetModel.user_id == user_id)
                & (
                    BudgetModel.effective_from <= period_start
                )
                & (
                    (BudgetModel.effective_to.is_(None))
                    | (BudgetModel.effective_to >= period_start)
                ),
                isouter=True,
            )

            # Join EXPENSE transactions
            .join(
                TransactionModel,
                (TransactionModel.category_id == CategoryModel.id)
                & (TransactionModel.user_id == user_id)
                & (TransactionModel.type == "Expense"),
                isouter=True,
            )

            .group_by(
                CategoryModel.id,
                CategoryModel.name,
                CategoryModel.short_name,
            )
            .order_by(CategoryModel.name)
        )

        # ----------------------------------------------------------
        # Apply TRANSACTION period filter
        # ----------------------------------------------------------

        stmt = self._apply_period_filter(
            stmt,
            TransactionModel.transaction_date,
            norm_year,
            norm_month if use_month else None,
        )

        # ----------------------------------------------------------
        # Execute
        # ----------------------------------------------------------

        result = await self.db.execute(stmt)

        # ----------------------------------------------------------
        # Build response
        # ----------------------------------------------------------

        data = []

        for r in result:
            budget = float(r.budget or 0)
            spent = float(r.spent or 0)

            usage = (spent / budget * 100) if budget else None

            data.append(
                {
                    "category_id": r.category_id,
                    "category_name": r.category_name,
                    "short_name": r.short_name,
                    "budget": round(budget, 2),
                    "spent": round(spent, 2),
                    "remaining": round(budget - spent, 2) if budget else None,
                    "usage_percent": round(usage, 2) if usage is not None else None,
                }
            )

        return data

    # ============================================================
    # RECENT TRANSACTIONS
    # ============================================================
    async def get_recent_transactions(
        self,
        user_id: int,
        year: int | None = None,
        month: int | None = None,
        limit: int = 10,
    ):
        norm_year, norm_month, use_month = self._normalize_period(year, month)

        stmt = (
            select(
                TransactionModel.id,
                TransactionModel.description,
                TransactionModel.amount,
                TransactionModel.type,
                TransactionModel.transaction_date,
                CategoryModel.name.label("category"),
            )
            .select_from(TransactionModel)
            .join(CategoryModel, CategoryModel.id == TransactionModel.category_id)
            .where(TransactionModel.user_id == user_id)
            .order_by(TransactionModel.transaction_date.desc())
            .limit(limit)
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
                "id": r.id,
                "description": r.description,
                "amount": r.amount,
                "type": r.type,
                "category": r.category,
                "transaction_date": r.transaction_date,
            }
            for r in result
        ]

    # ============================================================
    # ACCOUNTS
    # ============================================================
    async def get_accounts(self, user_id: int):
        stmt = (
            select(AccountModel)
            .where(AccountModel.user_id == user_id)
            .order_by(AccountModel.name)
        )

        result = await self.db.execute(stmt)

        return [
            {
                "id": acc.id,
                "name": acc.name,
                "type": acc.type,
                "balance": acc.balance,
                "currency": acc.currency,
            }
            for acc in result.scalars().all()
        ]
