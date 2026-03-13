# app/seed/faker_seed.py
from typing import Optional
from faker import Faker
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import func, select
from datetime import datetime, timedelta
import random

from app.models.user_model import UserModel
from app.models.account_model import AccountModel
from app.models.category_model import CategoryModel
from app.models.transaction_model import TransactionModel
from app.models.budget_model import BudgetModel


fake = Faker()
SEED = 12345
Faker.seed(SEED)
random.seed(SEED)

CATEGORIES_DATA = [
    (
        1,
        "Food & Dining",
        "Meals, groceries, cafes, restaurants, and takeout orders",
        22,
    ),
    (
        2,
        "Transportation",
        "Fuel, public transit, ride-hailing, parking, and vehicle expenses",
        10,
    ),
    (
        3,
        "Housing",
        "Rent, mortgage payments, property maintenance, and household utilities",
        30,
    ),
    (
        4,
        "Healthcare",
        "Doctor visits, pharmacy purchases, medical insurance, and hospital bills",
        6,
    ),
    (
        5,
        "Entertainment",
        "Movies, streaming subscriptions, concerts, gaming, and leisure activities",
        5,
    ),
    (6, "Travel", "Flights, hotels, vacation packages, and related travel costs", 4),
    (
        7,
        "Shopping",
        "Clothing, electronics, household goods, and personal purchases",
        8,
    ),
    (
        8,
        "Education",
        "Tuition fees, online courses, books, and professional training",
        5,
    ),
    (
        9,
        "Utilities",
        "Recurring service bills like internet, phone, cable, and electricity",
        8,
    ),
    (10, "Miscellaneous", "Catch-all for irregular or uncategorized expenses", 2),
    # (11, "Income", "Income from Salary, Bank/UPI/Other Online Transfer,", 0),
]

CATEGORY_MAP = {cat_id: name for cat_id, name, _, _ in CATEGORIES_DATA}


async def seed_budgets(db: AsyncSession, effective_from: Optional[datetime] = None):
    print("Seeding Monthly Budgets...")

    db_effective_from = effective_from or datetime.today()

    for user_id in range(1, 50):

        total_amount = random.randint(2, 4) * 10000  # realistic monthly budget

        # Insert total budget first
        db.add(
            BudgetModel(
                name="Monthly Total Budget",
                amount=total_amount,
                period="Monthly",
                currency="INR",
                effective_from=db_effective_from,
                user_id=user_id,
                category_id=None,
                version=1,
                is_active=True,
            )
        )

        # Insert category-wise budgets
        for cat_id, name, _, ratio in CATEGORIES_DATA:
            db.add(
                BudgetModel(
                    name=f"{name} Budget",
                    amount=int(total_amount * ratio / 100),
                    period="Monthly",
                    currency="INR",
                    effective_from=db_effective_from,
                    user_id=user_id,
                    category_id=cat_id,
                    version=1,
                    is_active=True,
                )
            )

    await db.commit()
    print("Budgets seeded!")


import random
import calendar
from datetime import datetime, timedelta
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.account_model import AccountModel
from app.models.budget_model import BudgetModel
from app.models.transaction_model import TransactionModel

# CATEGORY_MAP assumed already defined elsewhere


async def seed_transactions(
    db: AsyncSession,
    date_from: datetime,
    date_to: datetime,
    total_num_txns: int,
):
    print("Seeding transactions...")

    # ---------------------------------------------------
    # Load Accounts
    # ---------------------------------------------------
    accounts = await db.execute(select(AccountModel))
    accounts = accounts.scalars().all()

    if not accounts:
        print("No accounts found, skipping transaction seeding.")
        return

    user_ids = list(set(a.user_id for a in accounts))
    total_users = len(user_ids)

    print(f"Found users: {total_users}")

    # ---------------------------------------------------
    # Distribute expenses evenly with randomness
    # ---------------------------------------------------
    base_share = total_num_txns // total_users
    per_user_txn = {}

    for uid in user_ids:
        per_user_txn[uid] = max(base_share + random.randint(-25, 25), 0)

    allocated = sum(per_user_txn.values())
    delta = total_num_txns - allocated

    while delta != 0:
        uid = random.choice(user_ids)
        if delta > 0:
            per_user_txn[uid] += 1
            delta -= 1
        elif per_user_txn[uid] > 0:
            per_user_txn[uid] -= 1
            delta += 1

    # ---------------------------------------------------
    # EXPENSE seeding
    # ---------------------------------------------------
    expense_created = 0

    for acc in accounts:
        user_id = acc.user_id
        account_id = acc.id
        txn_count = per_user_txn[user_id]

        if txn_count <= 0:
            continue

        budgets = await db.execute(
            select(BudgetModel).where(
                BudgetModel.user_id == user_id,
                BudgetModel.category_id.isnot(None),
                BudgetModel.is_active == True
            )
        )
        budgets = budgets.scalars().all()

        if not budgets:
            continue

        for _ in range(txn_count):
            budget = random.choice(budgets)

            # Random date
            txn_date = date_from + timedelta(
                days=random.randrange((date_to - date_from).days + 1)
            )

            cat_budget = max(budget.amount, 1000)

            # --------------------------------------------------
            # NEW realistic multi-tier spend model
            # --------------------------------------------------
            roll = random.random()

            if roll < 0.50:
                # Small spends (daily groceries, coffee, metro)
                pct = random.uniform(0.01, 0.04)
            elif roll < 0.85:
                # Medium normal shopping
                pct = random.uniform(0.04, 0.10)
            else:
                # Large occasional purchase
                pct = random.uniform(0.10, 0.25)

            amount = cat_budget * pct

            # Occasionally push very high spends (budget spikes)
            if random.random() < 0.05:
                amount *= random.uniform(1.2, 2.0)

            # Enforce minimum of 200 and round to nearest 100
            amount = max(200, round(amount / 100) * 100)

            expense_txn = TransactionModel(
                description="Expense - " + CATEGORY_MAP.get(
                    budget.category_id,
                    "Misc"
                ),
                amount=amount,
                type="Expense",
                currency="INR",
                user_id=user_id,
                account_id=account_id,
                category_id=budget.category_id,
                transaction_date=txn_date,
            )

            db.add(expense_txn)
            expense_created += 1

    print(f"✅ Expenses created: {expense_created}")

    # ---------------------------------------------------
    # INCOME seeding (unchanged logic)
    # ---------------------------------------------------
    months = []
    cursor = date_from.replace(day=1)
    while cursor <= date_to:
        months.append((cursor.year, cursor.month))
        if cursor.month == 12:
            cursor = cursor.replace(year=cursor.year + 1, month=1)
        else:
            cursor = cursor.replace(month=cursor.month + 1)

    income_created = 0

    for acc in accounts:
        user_id = acc.user_id
        account_id = acc.id

        total_budget = (
            await db.execute(
                select(func.coalesce(func.sum(BudgetModel.amount), 0)).where(
                    BudgetModel.user_id == user_id,
                    BudgetModel.category_id.is_(None),
                    BudgetModel.is_active == True,
                )
            )
        ).scalar() or 50000

        for year, month in months:
            income_count = random.randint(1, 3)
            days = calendar.monthrange(year, month)[1]

            for _ in range(income_count):
                d = random.randint(1, days)
                txn_date = datetime(year, month, d)

                if not (date_from <= txn_date <= date_to):
                    continue

                base = total_budget / income_count
                uplift = random.uniform(1.20, 1.30)

                income_amt = round((base * uplift) / 100) * 100

                income_txn = TransactionModel(
                    description="Salary Income",
                    amount=income_amt,
                    type="Income",
                    currency="INR",
                    user_id=user_id,
                    account_id=account_id,
                    category_id=11,
                    transaction_date=txn_date,
                )

                db.add(income_txn)
                income_created += 1

    # ---------------------------------------------------
    # Commit
    # ---------------------------------------------------
    await db.commit()

    print("✅ TRANSACTION SEEDING COMPLETE")
