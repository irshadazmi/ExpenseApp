from app.schemas.account_schema import AccountCreateSchema, AccountUpdateSchema
from app.utils.exceptions import FailedToUpdateException

class AccountService:
    def __init__(self, account_repository):
        self.account_repository = account_repository

    async def get_all_accounts(self, skip: int = 0, limit: int = 10):
        return await self.account_repository.get_all_accounts(skip, limit)
    
    async def get_account_by_id(self, account_id: int):
        return await self.account_repository.get_account_by_id(account_id)
    
    async def create_account(self, account: AccountCreateSchema):
        account_dict = account.dict()
        return await self.account_repository.create_account(account_dict)
    
    async def update_account(self, account_id: int, account: AccountUpdateSchema):
        if account.balance < 0:
            raise FailedToUpdateException(detail="Balance cannot be negative")
        
        account_dict = account.dict(exclude_unset=True)
        return self.account_repository.update_account(account_id, account_dict)
    
    async def delete_account(self, account_id: int):
        return await self.account_repository.delete_account(account_id)