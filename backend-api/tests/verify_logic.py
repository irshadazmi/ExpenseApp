import asyncio
import sys
import os
from unittest.mock import MagicMock, AsyncMock
from datetime import datetime

# Add the project root to sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app.repositories.transaction_repository import TransactionRepository
from app.schemas.transaction_schema import TransactionCreateSchema, TransactionUpdateSchema
from app.models.transaction_model import TransactionModel
from app.models.account_model import AccountModel

async def test_create_transaction_income():
    print("Testing create_transaction (Income)...")
    mock_db = AsyncMock()
    repo = TransactionRepository(mock_db)

    # Mock account
    mock_account = AccountModel(id=1, balance=100.0, type="Bank", name="Test Account", currency="INR", user_id=1)
    
    # Mock db.execute to return the account
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = mock_account
    mock_db.execute.return_value = mock_result

    transaction_data = TransactionCreateSchema(
        description="Salary",
        amount=500.0,
        category_id=1,
        account_id=1,
        type="Income",
        currency="INR",
        user_id=1,
        transaction_date=datetime.now()
    )

    await repo.create_transaction(transaction_data)

    # Check if balance updated
    if mock_account.balance == 600.0:
        print("PASS: Balance updated correctly (100 + 500 = 600)")
    else:
        print(f"FAIL: Balance mismatch. Expected 600.0, got {mock_account.balance}")

async def test_create_transaction_expense():
    print("\nTesting create_transaction (Expense)...")
    mock_db = AsyncMock()
    repo = TransactionRepository(mock_db)

    # Mock account
    mock_account = AccountModel(id=1, balance=100.0, type="Bank", name="Test Account", currency="INR", user_id=1)
    
    # Mock db.execute to return the account
    mock_result = MagicMock()
    mock_result.scalars.return_value.first.return_value = mock_account
    mock_db.execute.return_value = mock_result

    transaction_data = TransactionCreateSchema(
        description="Groceries",
        amount=50.0,
        category_id=1,
        account_id=1,
        type="Expense",
        currency="INR",
        user_id=1,
        transaction_date=datetime.now()
    )

    await repo.create_transaction(transaction_data)

    # Check if balance updated
    if mock_account.balance == 50.0:
        print("PASS: Balance updated correctly (100 - 50 = 50)")
    else:
        print(f"FAIL: Balance mismatch. Expected 50.0, got {mock_account.balance}")

async def test_delete_transaction():
    print("\nTesting delete_transaction (Revert Expense)...")
    mock_db = AsyncMock()
    repo = TransactionRepository(mock_db)

    # Mock transaction
    mock_transaction = TransactionModel(
        id=1,
        description="Groceries",
        amount=50.0,
        type="Expense",
        account_id=1,
        user_id=1
    )

    # Mock account
    mock_account = AccountModel(id=1, balance=50.0, type="Bank", name="Test Account", currency="INR", user_id=1)

    # Mock db.execute to return transaction then account
    mock_result_transaction = MagicMock()
    mock_result_transaction.scalars.return_value.first.return_value = mock_transaction
    
    mock_result_account = MagicMock()
    mock_result_account.scalars.return_value.first.return_value = mock_account

    mock_db.execute.side_effect = [mock_result_transaction, mock_result_account]

    await repo.delete_transaction(1)

    # Check if balance reverted
    if mock_account.balance == 100.0:
        print("PASS: Balance reverted correctly (50 + 50 = 100)")
    else:
        print(f"FAIL: Balance mismatch. Expected 100.0, got {mock_account.balance}")

async def main():
    await test_create_transaction_income()
    await test_create_transaction_expense()
    await test_delete_transaction()

if __name__ == "__main__":
    asyncio.run(main())
