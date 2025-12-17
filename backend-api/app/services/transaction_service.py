from typing import Optional
from app.utils.exceptions import FailedToCreateException, FailedToUpdateException
from app.schemas.transaction_schema import TransactionCreateSchema, TransactionUpdateSchema

class TransactionService:
    def __init__(self, transaction_repository):
        self.transaction_repository = transaction_repository
    
    async def get_transactions_grouped_by_category(self):
        return await self.transaction_repository.get_transactions_grouped_by_category()
    
    async def get_category_wise_totals(self):
        return await self.transaction_repository.get_category_wise_totals()
    
    async def get_all_transactions(self, user_id: Optional[int] = None):
        return await self.transaction_repository.get_all_transactions(user_id)

    async def get_transaction_by_id(self, transaction_id: int):
        return await self.transaction_repository.get_transaction_by_id(transaction_id)

    async def create_transaction(self, transaction_data: TransactionCreateSchema):
        if transaction_data.amount < 0:
            raise FailedToCreateException(detail="Transaction amount cannot be negative")

        return await self.transaction_repository.create_transaction(transaction_data)

    async def update_transaction(self, transaction_id: int, transaction_data: TransactionUpdateSchema):
        if transaction_data.amount < 0:
            raise FailedToUpdateException(detail="Transaction amount cannot be negative")

        return await self.transaction_repository.update_transaction(transaction_id, transaction_data)

    async def delete_transaction(self, transaction_id: int):
        return await self.transaction_repository.delete_transaction(transaction_id)
