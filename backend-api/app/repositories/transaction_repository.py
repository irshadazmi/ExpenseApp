from datetime import datetime
from typing import Optional
from sqlalchemy import select
from app.schemas.transaction_schema import TransactionCreateSchema, TransactionUpdateSchema
from app.models.transaction_model import TransactionModel
from app.models.account_model import AccountModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)

class TransactionRepository:
    def __init__(self, db):
        self.db = db

    async def get_all_transactions(self, user_id: Optional[int] = None):
        stmt = select(TransactionModel)

        if user_id is not None:
            stmt = stmt.where(TransactionModel.user_id == user_id)

        result = await self.db.execute(stmt)
        rows = result.scalars().all()

        if not rows:
            return []

        return rows

    async def get_transaction_by_id(self, transaction_id: int):
        result = await self.db.execute(
            select(TransactionModel).where(TransactionModel.id == transaction_id)
        )
        transaction = result.scalars().first()
        if not transaction:
            raise RecordNotFoundException("Transaction not found")
        return transaction

    async def create_transaction(self, transaction: TransactionCreateSchema) -> TransactionModel:
        db_transaction = TransactionModel(**transaction.dict(exclude_unset=True))

        try:
            # Fetch the account
            result = await self.db.execute(select(AccountModel).where(AccountModel.id == transaction.account_id))
            account = result.scalars().first()
            if not account:
                raise RecordNotFoundException("Account not found")

            # Update account balance
            if transaction.type.lower() == "income":
                account.balance += transaction.amount
            elif transaction.type.lower() == "expense":
                account.balance -= transaction.amount
            
            self.db.add(db_transaction)
            await self.db.commit()
            await self.db.refresh(db_transaction)
            await self.db.refresh(account)
            return db_transaction
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_transaction(self, transaction_id: int, transaction_data: dict):
        result = await self.db.execute(select(TransactionModel).where(TransactionModel.id == transaction_id))
        existing_transaction = result.scalars().first()

        if not existing_transaction:
            raise RecordNotFoundException("Transaction not found")

        # Fetch the account
        # Assuming account_id is not changeable for now, or if it is, we need to handle moving amounts between accounts.
        # For simplicity, let's assume we are updating the same account or if account_id changes, we handle it.
        # But first let's handle balance update on the same account or if account changes.
        
        # We need to revert the old transaction effect
        old_account_id = existing_transaction.account_id
        old_amount = existing_transaction.amount
        old_type = existing_transaction.type

        result_old_account = await self.db.execute(select(AccountModel).where(AccountModel.id == old_account_id))
        old_account = result_old_account.scalars().first()
        
        if not old_account:
             raise RecordNotFoundException("Associated account not found")

        if old_type.lower() == "income":
            old_account.balance -= old_amount
        elif old_type.lower() == "expense":
            old_account.balance += old_amount

        # Apply new transaction effect
        # Check if account_id is being updated
        new_account_id = transaction_data.get("account_id", old_account_id)
        
        if new_account_id != old_account_id:
             result_new_account = await self.db.execute(select(AccountModel).where(AccountModel.id == new_account_id))
             new_account = result_new_account.scalars().first()
             if not new_account:
                 raise RecordNotFoundException("New account not found")
             current_account = new_account
        else:
             current_account = old_account

        for key, value in transaction_data.items():
            setattr(existing_transaction, key, value)
            
        new_amount = existing_transaction.amount
        new_type = existing_transaction.type

        if new_type.lower() == "income":
            current_account.balance += new_amount
        elif new_type.lower() == "expense":
            current_account.balance -= new_amount

        try:
            existing_transaction.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(existing_transaction)
            await self.db.refresh(current_account)
            if new_account_id != old_account_id:
                 await self.db.refresh(old_account)
            return existing_transaction
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_transaction(self, transaction_id: int):
        result = await self.db.execute(
            select(TransactionModel).where(TransactionModel.id == transaction_id)
        )
        transaction = result.scalars().first()
        if not transaction:
            raise RecordNotFoundException("Transaction not found")

        try:
            # Revert balance
            result_account = await self.db.execute(select(AccountModel).where(AccountModel.id == transaction.account_id))
            account = result_account.scalars().first()
            
            if account:
                if transaction.type.lower() == "income":
                    account.balance -= transaction.amount
                elif transaction.type.lower() == "expense":
                    account.balance += transaction.amount
            
            # Hard delete or soft delete? The original code did soft delete (is_active=False) but TransactionModel doesn't seem to have is_active in the view I saw earlier?
            # Wait, let me check TransactionModel again. It has id, description, amount, type, currency, category_id, user_id, transaction_date, created_at, updated_at.
            # It DOES NOT have is_active.
            # The original code was:
            # transaction.is_active = False
            # This would have failed if is_active is not in the model.
            # Let me assume I should do a hard delete for now or check if I missed is_active in the model view.
            # Looking at step 19, TransactionModel does NOT have is_active.
            # So the original code was likely buggy or I missed something.
            # I will change it to hard delete for now to be safe, or just delete the record.
            
            await self.db.delete(transaction)
            await self.db.commit()
            if account:
                await self.db.refresh(account)
            return transaction
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
