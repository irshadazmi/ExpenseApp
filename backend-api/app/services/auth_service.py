# backend-api/app/services/auth_service.py
from jose import jwt, JWTError
from app.repositories.auth_repository import AuthRepository
from app.core.security import get_password_hash, verify_password
from app.core.jwt import create_access_token
from app.schemas.auth_schema import (
    AuthResponseSchema,
    AuthRegisterSchema,
    AuthLoginSchema,
    AuthResultSchema,
    Token,
)
from app.utils.exceptions import (
    AuthenticationFailedException,
    EmailOrPhoneAlreadyExistsException,
    AuthenticationFailedException,
    RecordNotFoundException,
    FailedToUpdateException,
)
from app.core.config import settings


class AuthService:
    def __init__(self, auth_repository: AuthRepository):
        self.auth_repository = auth_repository

    async def get_current_user_from_token(self, token: str) -> AuthResultSchema:
        try:
            payload = jwt.decode(
                token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
            )
            email = payload.get("sub")
            if not email:
                return None
        except JWTError:
            return None

        user = await self.auth_repository.get_user_by_email(email)
        if not user or not user.is_active:
            return None

        user_schema = AuthResponseSchema(
            id=user.id,
            full_name=user.full_name,
            email=user.email,
            phone=user.phone,
            role_id=user.role_id,
            is_active=user.is_active,
        )
        token_schema = Token(
            access_token=token,
            token_type="bearer",
        )
        return AuthResultSchema(
            user=user_schema,
            token=token_schema,
        )

    async def find_user_by_email(self, email: str):
        return await self.auth_repository.get_user_by_email(email)

    async def find_user_by_phone(self, phone: str):
        return await self.auth_repository.get_user_by_phone(phone)

    async def register_user(self, user: AuthRegisterSchema) -> AuthResultSchema:
        # Prepare user data
        user_dict = user.dict(exclude={"confirm_password"})
        user_dict["password"] = get_password_hash(user_dict["password"])

        # Register user and generate token
        new_user = await self.auth_repository.register_user(user_dict)
        token = create_access_token({"sub": new_user.email})

        # Build user and token schemas explicitly
        user_schema = AuthResponseSchema(
            id=new_user.id,
            full_name=new_user.full_name,
            email=new_user.email,
            phone=new_user.phone,
            role_id=new_user.role_id,
            is_active=new_user.is_active,
        )
        token_schema = Token(
            access_token=token,
            token_type="bearer",
        )

        return AuthResultSchema(
            user=user_schema,
            token=token_schema,
        )

    async def login_user(self, credentials: AuthLoginSchema) -> AuthResultSchema:
        existing_user = await self.auth_repository.get_user_by_email(credentials.email)
        if not existing_user or not verify_password(
            credentials.password, existing_user.password
        ):
            raise AuthenticationFailedException("Invalid email or password")

        token = create_access_token({"sub": existing_user.email})

        # Build objects with only the expected fields
        user_schema = AuthResponseSchema(
            id=existing_user.id,
            full_name=existing_user.full_name,
            email=existing_user.email,
            phone=existing_user.phone,
            role_id=existing_user.role_id,
            is_active=existing_user.is_active,
        )
        token_schema = Token(
            access_token=token,
            token_type="bearer",
        )
        return AuthResultSchema(
            user=user_schema,
            token=token_schema,
        )

    async def update_user(self, user_id: int, user_data: dict):
        # Ensure user exists
        existing_user = await self.auth_repository.get_user_by_id(user_id)
        if not existing_user:
            raise RecordNotFoundException("User not found")

        # Check for duplicate email or phone
        duplicate_user = await self.auth_repository.get_user_by_email_or_phone(
            email=user_data.get("email"),
            phone=user_data.get("phone"),
            exclude_id=user_id,
        )
        if duplicate_user:
            raise EmailOrPhoneAlreadyExistsException(
                "Email or phone already exists. Please use a different email or phone"
            )

        # user_data = user_data(exclude={'confirm_password'})
        user_data["password"] = get_password_hash(user_data["password"])

        # Perform update
        updated_user = await self.auth_repository.update_user(user_id, user_data)
        if not updated_user:
            raise FailedToUpdateException("Failed to update user")
        return updated_user
