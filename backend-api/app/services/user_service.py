from app.repositories.user_repository import UserRepository
from app.core.security import get_password_hash
from app.schemas.user_schema import UserCreateSchema, UserUpdateSchema

class UserService:
    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository

    async def find_user_by_email(self, email: str):
        return await self.user_repository.get_user_by_email(email)
    
    async def find_user_by_phone(self, phone: str):
        return await self.user_repository.get_user_by_phone(phone)
    
    async def get_user_by_id(self, user_id: int):
        return await self.user_repository.get_user_by_id(user_id)

    async def get_all_users(self, skip: int = 0, limit: int = 10):
        return await self.user_repository.get_all_users(skip, limit)

    async def create_user(self, user: UserCreateSchema):
        user_dict = user.dict(exclude={'confirm_password'})
        user_dict["password"] = get_password_hash(user_dict["password"])
        return await self.user_repository.create_user(user_dict)

    async def update_user(self, user_id: int, user_data: UserUpdateSchema):
        # user_data = user_data(exclude={'confirm_password'})
        user_data["password"] = get_password_hash(user_data["password"])
        return await self.user_repository.update_user(user_id, user_data)

    async def delete_user(self, user_id: int):
        return await self.user_repository.delete_user(user_id)