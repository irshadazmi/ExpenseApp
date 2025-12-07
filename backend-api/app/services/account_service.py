# backend-api/app/services/account_service.py
from typing import Optional
from app.schemas.account_schema import AccountCreateSchema, AccountUpdateSchema
from app.utils.exceptions import FailedToUpdateException

class AccountService:
    def __init__(self, account_repository):
        self.account_repository = account_repository

    async def get_all_accounts(self, user_id: Optional[int] = None):
        return await self.account_repository.get_all_accounts(user_id)
    
    async def get_account_by_id(self, account_id: int):
        return await self.account_repository.get_account_by_id(account_id)
    
    async def create_account(self, account_data: AccountCreateSchema):
        if account_data.balance < 0:
            raise FailedToUpdateException(detail="Balance cannot be negative")
        
        account_dict = account_data.model_dump()
        return await self.account_repository.create_account(account_dict)
    
    async def update_account(self, account_id: int, account_data: AccountUpdateSchema):
        if account_data.balance < 0:
            raise FailedToUpdateException(detail="Balance cannot be negative")

        account_dict = account_data.model_dump(exclude_unset=True)
        return await self.account_repository.update_account(account_id, account_dict)
    
    async def delete_account(self, account_id: int):
        return await self.account_repository.delete_account(account_id)