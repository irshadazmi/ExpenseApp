from datetime import datetime
from typing import Optional
from sqlalchemy import select
from app.schemas.transaction_schema import TransactionCreateSchema, TransactionUpdateSchema
from app.models.transaction_model import TransactionModel
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
            self.db.add(db_transaction)
            await self.db.commit()
            await self.db.refresh(db_transaction)
            return db_transaction
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_transaction(self, transaction_id: int, transaction_data: dict):
        result = await self.db.execute(select(TransactionModel).where(TransactionModel.id == transaction_id))
        existing_transaction = result.scalars().first()

        if not existing_transaction:
            raise RecordNotFoundException("Transaction not found")

        # update_data = transaction_data.dict(exclude_unset=True)
        for key, value in transaction_data.items():
            setattr(existing_transaction, key, value)

        try:
            existing_transaction.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(existing_transaction)
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
            transaction.is_active = False
            transaction.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(transaction)
            return transaction
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
