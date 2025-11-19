from datetime import datetime
from sqlalchemy import select
from app.schemas.account_schema import AccountResponseSchema
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

    async def get_all_accounts(self, skip: int = 0, limit: int = 10):
        result = await self.db.execute(select(AccountModel).offset(skip).limit(limit))
        if not result:
            raise RecordNotFoundException("No account records found")
        return result.scalars().all()

    async def get_account_by_id(self, account_id: int):
        result = await self.db.execute(
            select(AccountModel).where(AccountModel.id == account_id)
        )
        account = result.scalars().first()
        if not account:
            raise RecordNotFoundException("Account not found")
        return account

    async def create_account(self, account: AccountResponseSchema) -> AccountModel:
        db_account = AccountModel(**account.dict(exclude_unset=True))

        try:
            self.db.add(db_account)
            await self.db.commit()
            await self.db.refresh(db_account)
            return db_account
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_account(
        self, account_id: int, account_data: AccountResponseSchema
    ) -> AccountModel:
        result = await self.db.execute(
            select(AccountModel).where(AccountModel.id == account_id)
        )
        account = result.scalars().first()

        if not account:
            raise RecordNotFoundException("Account not found")

        update_data = account_data.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(account, key, value)

        try:
            account.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(account)
            return account
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
