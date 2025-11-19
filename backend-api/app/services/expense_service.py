from app.utils.exceptions import FailedToCreateException, FailedToUpdateException

class ExpenseService:
    def __init__(self, expense_repository):
        self.expense_repository = expense_repository
    
    async def get_expenses_grouped_by_category(self):
        return await self.expense_repository.get_expenses_grouped_by_category()

    
    async def get_category_wise_totals(self):
        return await self.expense_repository.get_category_wise_totals()

    async def get_all_expenses(self, skip: int = 0, limit: int = 10):
        return await self.expense_repository.get_all_expenses(skip, limit)

    async def get_expense_by_id(self, expense_id: int):
        return await self.expense_repository.get_expense_by_id(expense_id)

    async def create_expense(self, expense: dict):
        if expense.amount < 0:
            raise FailedToCreateException(detail="Expense amount cannot be negative")

        return await self.expense_repository.create_expense(expense)

    async def update_expense(self, expense_id: int, expense_data: dict):
        if expense_data.amount < 0:
            raise FailedToUpdateException(detail="Expense amount cannot be negative")

        return await self.expense_repository.update_expense(expense_id, expense_data)

    async def delete_expense(self, expense_id: int):
        return await self.expense_repository.delete_expense(expense_id)
