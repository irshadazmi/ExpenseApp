from sqlalchemy import select, func
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
    # SUMMARY
    # ============================================================
    async def get_summary(self, user_id: int):

        # ------------------------
        # Total Budget
        # ------------------------
        stmt_budget = (
            select(func.coalesce(func.sum(BudgetModel.amount), 0))
            .where(
                BudgetModel.user_id == user_id,
                BudgetModel.category_id.is_(None),
                BudgetModel.is_active == True,
            )
        )
        total_budget = (await self.db.execute(stmt_budget)).scalar() or 0

        # ------------------------
        # Total Spent
        # ------------------------
        stmt_spent = (
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(
                TransactionModel.user_id == user_id,
                TransactionModel.type == "Expense",
            )
        )
        total_spent = (await self.db.execute(stmt_spent)).scalar() or 0

        remaining = total_budget - total_spent
        usage_percent = round((total_spent / total_budget) * 100, 2) if total_budget else 0

        # ------------------------
        # Period calculation (✅ Python — no SQL interval)
        # ------------------------
        today = date.today()
        days_elapsed = today.day
        days_in_month = calendar.monthrange(today.year, today.month)[1]

        daily_budget = total_budget / days_in_month if total_budget else 0
        daily_spend = total_spent / max(days_elapsed, 1)

        if daily_spend > daily_budget:
            risk = "over_budget"
        elif daily_spend >= daily_budget * 0.9:
            risk = "on_track"
        else:
            risk = "under_budget"

        return {
            "totals": {
                "budget": round(total_budget, 2),
                "spent": round(total_spent, 2),
                "remaining": round(remaining, 2),
                "usage_percent": usage_percent,
            },
            "burn_rate": {
                "daily_budget": round(daily_budget, 2),
                "daily_spend": round(daily_spend, 2),
                "risk": risk,
            },
            "period": {
                "days_elapsed": days_elapsed,
                "days_in_month": days_in_month,
            },
        }

    # ============================================================
    # CATEGORY REPORT
    # ============================================================
    async def get_category_report(self, user_id: int):

        stmt = (
            select(
                CategoryModel.id.label("category_id"),
                CategoryModel.name.label("category_name"),
                func.coalesce(func.sum(BudgetModel.amount), 0).label("budget"),
                func.coalesce(func.sum(TransactionModel.amount), 0).label("spent"),
            )
            .select_from(CategoryModel)
            .join(
                BudgetModel,
                (BudgetModel.category_id == CategoryModel.id)
                & (BudgetModel.user_id == user_id)
                & (BudgetModel.is_active == True),
                isouter=True,
            )
            .join(
                TransactionModel,
                (TransactionModel.category_id == CategoryModel.id)
                & (TransactionModel.user_id == user_id)
                & (TransactionModel.type == "Expense"),
                isouter=True,
            )
            .group_by(CategoryModel.id, CategoryModel.name)
            .order_by(CategoryModel.name)
        )

        result = await self.db.execute(stmt)

        data = []
        for r in result.all():
            budget = float(r.budget)
            spent = float(r.spent)

            usage = (spent / budget * 100) if budget else None

            data.append({
                "category_id": r.category_id,
                "category_name": r.category_name,
                "budget": round(budget, 2),
                "spent": round(spent, 2),
                "remaining": round(budget - spent, 2) if budget else None,
                "usage_percent": round(usage, 2) if usage else None,
            })

        return data

    # ============================================================
    # RECENT TRANSACTIONS
    # ============================================================
    async def get_recent_transactions(self, user_id: int, limit=10):

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
            for r in result.all()
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
