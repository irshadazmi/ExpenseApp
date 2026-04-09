# backend-api/app/repositories/auth_repository.py
from datetime import datetime
from sqlalchemy import select, and_, or_
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.auth_model import AuthModel
from app.schemas.auth_schema import AuthRegisterSchema
from app.utils.exceptions import (
    EmailOrPhoneAlreadyExistsException,
    FailedToCreateException,
    FailedToUpdateException,
    RecordNotFoundException,
)

class AuthRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_user_by_email(self, email: str):
        result = await self.db.execute(
            select(AuthModel).where(
                AuthModel.email == email, AuthModel.is_active == True
            )
        )
        if not result:
            raise RecordNotFoundException("No user with the given email found")
        return result.scalars().first()

    async def get_user_by_phone(self, phone: str):
        result = await self.db.execute(
            select(AuthModel).where(
                AuthModel.phone == phone, AuthModel.is_active == True
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
            conditions.append(AuthModel.email == email)
        if phone:
            conditions.append(AuthModel.phone == phone)

        if not conditions:
            return None  # If no conditions are given, return None

        query = select(AuthModel).where(and_(*conditions, AuthModel.id != exclude_id))

        result = await self.db.execute(query)
        return result.scalars().first()

    async def register_user(self, user_data: AuthRegisterSchema) -> AuthModel:
        if hasattr(user_data, "dict"):
            db_user = AuthModel(**user_data.dict(exclude_unset=True))
        else:
            db_user = AuthModel(**user_data)

        # Check for duplicate email or phone
        duplicate_user = await self.get_user_by_email_or_phone(
            email=user_data.get("email"),
            phone=user_data.get("phone"),
        )
        if duplicate_user:
            raise EmailOrPhoneAlreadyExistsException(
                "Email or phone already exists. Please use a different email or phone"
            )

        try:
            self.db.add(db_user)
            await self.db.commit()
            await self.db.refresh(db_user)
            return db_user
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_auth(self, user_id: int, user_data: dict):
        result = await self.db.execute(select(AuthModel).where(AuthModel.id == user_id))
        user = result.scalars().first()

        if not user:
            raise RecordNotFoundException("User not found")

        # Check for duplicate email or phone
        duplicate_user = await self.get_user_by_email_or_phone(
            email=user_data.get("email"),
            phone=user_data.get("phone"),
            exclude_id=user_id,
        )
        if duplicate_user:
            raise EmailOrPhoneAlreadyExistsException(
                "Email or phone already exists. Please use a different email or phone"
            )

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
