# app/repositories/dashboard_repository.py

from sqlalchemy import select, func
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.transaction_model import TransactionModel
from app.models.category_model import CategoryModel
from app.models.account_model import AccountModel
from app.models.budget_model import BudgetModel


class DashboardRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    # -------------------------------------------------------
    #  SUMMARY (Monthly KPI)
    # -------------------------------------------------------
    async def get_summary(self, user_id: int):
        # total expenses
        tx_stmt = (
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(
                TransactionModel.user_id == user_id,
                TransactionModel.type == "Expense"
            )
        )
        total_spent = (await self.db.execute(tx_stmt)).scalar()

        # income
        inc_stmt = (
            select(func.coalesce(func.sum(TransactionModel.amount), 0))
            .where(
                TransactionModel.user_id == user_id,
                TransactionModel.type == "Income"
            )
        )
        total_income = (await self.db.execute(inc_stmt)).scalar()

        # monthly budget
        bud_stmt = (
            select(func.coalesce(func.sum(BudgetModel.amount), 0))
            .where(
                BudgetModel.user_id == user_id,
                BudgetModel.category_id.is_(None),
                BudgetModel.is_active.is_(True)
            )
        )
        monthly_budget = (await self.db.execute(bud_stmt)).scalar()

        return {
            "total_budget": monthly_budget,
            "total_spent": total_spent,
            "total_income": total_income,
            "remaining": monthly_budget - total_spent,
            "usage_percent": round((total_spent / monthly_budget) * 100, 2)
            if monthly_budget else 0
        }

    # -------------------------------------------------------
    #  CATEGORY REPORT
    # -------------------------------------------------------
    async def get_category_report(self, user_id: int):

        stmt = (
            select(
                CategoryModel.id,
                CategoryModel.name,
                func.sum(TransactionModel.amount).label("spent"),
                func.coalesce(func.sum(BudgetModel.amount), 0).label("budget"),
            )
            .select_from(CategoryModel)
            .join(
                TransactionModel,
                CategoryModel.id == TransactionModel.category_id,
            )
            .outerjoin(
                BudgetModel,
                (BudgetModel.category_id == CategoryModel.id)
                & (BudgetModel.user_id == user_id)
                & (BudgetModel.is_active.is_(True)),
            )
            .where(TransactionModel.user_id == user_id)
            .group_by(CategoryModel.id, CategoryModel.name)
            .order_by(func.sum(TransactionModel.amount).desc())
        )

        result = await self.db.execute(stmt)
        return result.mappings().all()

    # -------------------------------------------------------
    #  RECENT TRANSACTIONS
    # -------------------------------------------------------
    async def get_recent_transactions(self, user_id: int, limit: int = 10):

        stmt = (
            select(
                TransactionModel.id,
                TransactionModel.description,
                TransactionModel.amount,
                TransactionModel.currency,
                TransactionModel.type,
                TransactionModel.transaction_date,
                CategoryModel.name.label("category"),
            )
            .select_from(TransactionModel)
            .join(CategoryModel)
            .where(TransactionModel.user_id == user_id)
            .order_by(TransactionModel.transaction_date.desc())
            .limit(limit)
        )

        result = await self.db.execute(stmt)
        return result.mappings().all()

    # -------------------------------------------------------
    #  ACCOUNT BALANCES
    # -------------------------------------------------------
    async def get_accounts(self, user_id: int):
        stmt = (
            select(
                AccountModel.id,
                AccountModel.name,
                AccountModel.type,
                AccountModel.balance,
                AccountModel.currency,
            )
            .where(AccountModel.user_id == user_id)
        )

        result = await self.db.execute(stmt)
        return result.mappings().all()
