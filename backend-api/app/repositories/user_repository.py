from datetime import datetime
from sqlalchemy import select, and_, or_
from sqlalchemy.ext.asyncio import AsyncSession
from app.schemas.user_schema import UserCreateSchema
from app.models.user_model import UserModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)


class UserRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_user_by_email(self, email: str):
        result = await self.db.execute(
            select(UserModel).where(
                UserModel.email == email, UserModel.is_active == True
            )
        )
        if not result:
            raise RecordNotFoundException("No user with the given email found")
        return result.scalars().first()

    async def get_user_by_phone(self, phone: str):
        result = await self.db.execute(
            select(UserModel).where(
                UserModel.phone == phone, UserModel.is_active == True
            )
        )
        if not result:
            raise RecordNotFoundException("No user with the given phone found")
        return result.scalars().first()

    async def get_user_by_email_or_phone(
        self, email: str = None, phone: str = None, exclude_id: int = None
    ):
        conditions = []
        if email:
            conditions.append(UserModel.email == email)
        if phone:
            conditions.append(UserModel.phone == phone)

        if not conditions:
            return None  # If no conditions are given, return None

        query = select(UserModel).where(and_(*conditions, UserModel.id != exclude_id))

        result = await self.db.execute(query)
        return result.scalars().first()

    async def get_all_users(self, skip: int = 0, limit: int = 10):
        result = await self.db.execute(select(UserModel).offset(skip).limit(limit))
        if not result:
            raise RecordNotFoundException("No user records found")
        return result.scalars().all()

    async def get_user_by_id(self, user_id: int):
        result = await self.db.execute(select(UserModel).where(UserModel.id == user_id))
        user = result.scalars().first()
        if not user:
            raise RecordNotFoundException("User not found")
        return user

    async def create_user(self, user_data: dict):
        db_user = UserModel(**user_data.dict(exclude_unset=True))

        try:
            self.db.add(db_user)
            await self.db.commit()
            await self.db.refresh(db_user)
            return db_user
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_user(self, user_id: int, user_data: UserCreateSchema) -> UserModel:
        result = await self.db.execute(select(UserModel).where(UserModel.id == user_id))
        user = result.scalars().first()

        if not user:
            raise RecordNotFoundException("User not found")

        update_data = user_data.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(user, key, value)

        try:
            user.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(user)
            return user
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_user(self, user_id: int):
        result = await self.db.execute(select(UserModel).where(UserModel.id == user_id))
        user = result.scalars().first()
        if not user:
            raise RecordNotFoundException("User not found")

        try:
            user.is_active = False
            user.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(user)
            return user
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
