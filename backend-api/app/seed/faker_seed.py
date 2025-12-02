# app/seed/faker_seed.py
from typing import Optional
from faker import Faker
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
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

async def seed_transactions(
    db: AsyncSession,
    date_from: datetime,
    date_to: datetime,
    total_num_txns: int
):
    print("Seeding Transactions...")

    # Fetch all accounts
    accounts = await db.execute(select(AccountModel))
    accounts = accounts.scalars().all()

    if not accounts:
        print("No accounts found, skipping transaction seeding.")
        return

    # Random distribution of total_num_txns across accounts
    remaining = total_num_txns
    user_txn_counts = {acc.user_id: 0 for acc in accounts}

    # Give each user a random base share
    for acc in accounts:
        share = random.randint(20, 80)  # variability
        user_txn_counts[acc.user_id] += share
        remaining -= share

    # Distribute remaining transactions randomly
    while remaining > 0:
        uid = random.choice(list(user_txn_counts.keys()))
        user_txn_counts[uid] += 1
        remaining -= 1

    # Now seed transactions per user
    for account in accounts:
        user_id = account.user_id
        account_id = account.id
        num_txns = user_txn_counts[user_id]

        # Get budgets for this user (skip total budget with category_id=None)
        budgets = await db.execute(
            select(BudgetModel).where(
                BudgetModel.user_id == user_id,
                BudgetModel.category_id.isnot(None)
            )
        )
        budgets = budgets.scalars().all()

        if not budgets:
            continue

        for _ in range(num_txns):
            budget = random.choice(budgets)

            # Pick a random date in range
            txn_date = date_from + timedelta(
                days=random.randrange(0, (date_to - date_from).days + 1)
            )

            # Ensure txn_date stays within bounds
            if txn_date < date_from:
                txn_date = date_from
            if txn_date > date_to:
                txn_date = date_to

            # Positive amount logic
            base_amt = int(max(200, budget.amount // (num_txns // len(budgets) + 1)))
            variation = random.randint(0, base_amt // 2)
            amount = base_amt + variation

            txn = TransactionModel(
                description="Expense - " + CATEGORY_MAP.get(budget.category_id, "Unknown"),
                amount=amount,
                type="Expense",
                currency="INR",
                user_id=user_id,
                account_id=account_id,
                category_id=budget.category_id,
                transaction_date=txn_date,
            )
            db.add(txn)

    await db.commit()
    print(f"Transactions seeded! Total: {total_num_txns}")


