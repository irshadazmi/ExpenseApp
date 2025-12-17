# backend-api/app/repositories/account_repository.py
from datetime import datetime
from typing import Optional
from sqlalchemy import select
from app.schemas.account_schema import AccountCreateSchema, AccountUpdateSchema
from app.models.account_model import AccountModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)

class AccountRepository:
    def __init__(self, db):
        self.db = db

    async def get_all_accounts(self, user_id: Optional[int] = None):
        stmt = select(AccountModel)

        if user_id is not None:
            stmt = stmt.where(AccountModel.user_id == user_id)

        result = await self.db.execute(stmt)
        rows = result.scalars().all()

        if not rows:
            return []

        return rows

    async def get_account_by_id(self, account_id: int):
        result = await self.db.execute(
            select(AccountModel).where(AccountModel.id == account_id)
        )
        account = result.scalars().first()
        if not account:
            raise RecordNotFoundException("Account not found")
        return account

    async def create_account(self, account: AccountCreateSchema) -> AccountModel:
        db_account = AccountModel(**account.dict(exclude_unset=True))

        try:
            self.db.add(db_account)
            await self.db.commit()
            await self.db.refresh(db_account)
            return db_account
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_account(self, account_id: int, account_data: dict):
        result = await self.db.execute(select(AccountModel).where(AccountModel.id == account_id))
        existing_account = result.scalars().first()

        if not existing_account:
            raise RecordNotFoundException("Account not found")

        # update_data = account_data.dict(exclude_unset=True)
        for key, value in account_data.items():
            setattr(existing_account, key, value)

        try:
            existing_account.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(existing_account)
            return existing_account
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_account(self, account_id: int):
        result = await self.db.execute(
            select(AccountModel).where(AccountModel.id == account_id)
        )
        account = result.scalars().first()
        if not account:
            raise RecordNotFoundException("Account not found")

        try:
            account.is_active = False
            account.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(account)
            return account
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
