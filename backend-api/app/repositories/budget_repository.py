# backend-api/app/repositories/budget_repository.py
from calendar import monthrange
from datetime import datetime
from typing import Optional
from sqlalchemy import func, not_, or_, select, update
from app.schemas.budget_schema import (
    BudgetCreateSchema,
    BudgetSnapshotItemSchema,
    BudgetUpdateSchema,
    SaveAllBudgetsSchema,
)
from app.models.budget_model import BudgetModel
from app.models.category_model import CategoryModel
from app.models.account_model import AccountModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToUpdateException,
    RecordNotFoundException,
)


class BudgetRepository:
    def __init__(self, db):
        self.db = db

    async def get_latest_version(self, user_id: int):
        result = await self.db.execute(
            select(func.max(BudgetModel.version)).where(BudgetModel.user_id == user_id)
        )
        return result.scalar()

    async def deactivate_user_budgets(self, user_id: int):
        await self.db.execute(
            update(BudgetModel)
            .where(
                BudgetModel.user_id == user_id,
            )
            .values(
                is_active=False,
                effective_to=datetime.utcnow(),
                updated_at=datetime.utcnow(),
            )
        )
        await self.db.commit()

    async def get_all_budgets(self, user_id: Optional[int] = None):
        result = await self.db.execute(
            select(func.max(BudgetModel.version)).where(BudgetModel.user_id == user_id)
        )
        user_max_version = result.scalar()

        stmt = (
            select(BudgetModel)
            .where(BudgetModel.user_id == user_id)
            .where(BudgetModel.version == user_max_version)
        )

        result = await self.db.execute(stmt)
        return result.scalars().all()

    async def get_budget_by_id(self, budget_id: int):
        result = await self.db.execute(
            select(BudgetModel).where(BudgetModel.id == budget_id)
        )
        return result.scalars().first()

    async def get_budget_of_month(
        self,
        user_id: int,
        year: int,
        month: int,
    ):
        target_month = datetime(year, month, 1)

        result = await self.db.execute(
            select(BudgetModel)
            .where(BudgetModel.user_id == user_id)
            .where(BudgetModel.category_id.is_(None))
            .order_by(BudgetModel.effective_from.asc())
        )

        budgets = result.scalars().all()

        if not budgets:
            raise RecordNotFoundException("No total budgets exist")

        # 1️⃣ Try exact validity
        valid = []
        for b in budgets:
            start = b.effective_from.replace(day=1)
            end = b.effective_to.replace(day=1) if b.effective_to else None

            if start <= target_month and (end is None or end >= target_month):
                valid.append(b)

        if valid:
            return sorted(valid, key=lambda b: b.effective_from)[-1]

        # 2️⃣ BACKFILL: nearest future budget
        future = [
            b for b in budgets
            if b.effective_from.replace(day=1) > target_month
        ]

        if future:
            return future[0]   # earliest future budget

        # 3️⃣ FINAL fallback: latest known budget
        return budgets[-1]
    
    # ------------------------------------------------------------
    # Total budget amount
    # ------------------------------------------------------------
    async def get_total_budget_amount(
        self,
        user_id: int,
        year: int,
        month: int | None = None,
    ) -> float:
        """
        - If month is provided → return that month's budget
        - If only year is provided → sum budgets ONLY for months
          where a budget was actually effective
        """

        # --------------------------------------------------
        # MONTHLY (delegate – already correct)
        # --------------------------------------------------
        if month is not None:
            budget = await self.get_budget_of_month(user_id, year, month)
            return float(budget.amount)

        # --------------------------------------------------
        # YEARLY (CORRECT LOGIC)
        # --------------------------------------------------

        # 1️⃣ Fetch ALL total budgets (history-aware)
        result = await self.db.execute(
            select(BudgetModel)
            .where(BudgetModel.user_id == user_id)
            .where(BudgetModel.category_id.is_(None))
            .order_by(BudgetModel.effective_from.asc())
        )

        budgets = result.scalars().all()

        if not budgets:
            raise RecordNotFoundException("No total budgets exist")

        total = 0.0

        # 2️⃣ Iterate through each month of the year
        for month_idx in range(1, 13):
            month_start = datetime(year, month_idx, 1)
            month_end = datetime(
                year,
                month_idx,
                monthrange(year, month_idx)[1],
                23,
                59,
                59,
            )

            # 3️⃣ Find budgets valid for THIS month
            valid = []
            for b in budgets:
                start = b.effective_from
                end = b.effective_to

                if start <= month_end and (end is None or end >= month_start):
                    valid.append(b)

            if not valid:
                # No budget existed for this month → skip
                continue

            # 4️⃣ Pick the most recent effective budget
            chosen = max(valid, key=lambda b: b.effective_from)

            total += float(chosen.amount)

        return total

    async def create_all_budgets(self, user_id: int):
        result = await self.db.execute(
            select(CategoryModel).where(not_(CategoryModel.short_name == "INCOM"))
        )
        categories = result.scalars().all()

        result = await self.db.execute(
            select(AccountModel).where(AccountModel.user_id == user_id)
        )
        currency = result.scalars().first().currency

        for category in categories:
            budget = BudgetCreateSchema(
                name=category.name + " Budget",
                user_id=user_id,
                category_id=category.id,
                amount=0.00,
                currency=currency,
                period="Monthly",
                effective_from=None,
                effective_to=None,
                is_active=True,
                version=0,
                created_at=datetime.utcnow(),
            )
            await self.create_budget(budget)
        budget = BudgetCreateSchema(
            name="Monthly Total Budget",
            user_id=user_id,
            category_id=None,
            amount=0.00,
            currency=currency,
            period="Monthly",
            effective_from=None,
            effective_to=None,
            is_active=True,
            version=0,
            created_at=datetime.utcnow(),
        )
        await self.create_budget(budget)

        return await self.get_all_budgets(user_id)

    async def create_budget(self, budget: BudgetCreateSchema) -> BudgetModel:
        db_budget = BudgetModel(**budget.dict(exclude_unset=True))

        try:
            self.db.add(db_budget)
            await self.db.commit()
            await self.db.refresh(db_budget)
            return db_budget
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_budget(
        self, budget_id: int, budget: BudgetUpdateSchema
    ) -> BudgetModel:

        db_budget = await self.get_budget_by_id(budget_id)
        if not db_budget:
            raise RecordNotFoundException("Budget not found")

        # ✅ Update fields in-place
        update_data = budget.dict(exclude_unset=True)

        for key, value in update_data.items():
            setattr(db_budget, key, value)

        # Set effective_from only if not already set
        if db_budget.effective_from is None:
            db_budget.effective_from = datetime.utcnow()

        db_budget.updated_at = datetime.utcnow()

        try:
            await self.db.commit()
            await self.db.refresh(db_budget)
            return db_budget
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))
