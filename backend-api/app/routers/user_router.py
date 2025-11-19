from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession
from app.schemas.user_schema import UserCreateSchema, UserUpdateSchema, UserResponseSchema
from app.services.user_service import UserService
from app.repositories.user_repository import UserRepository
from app.core.database import get_db
from app.utils.exceptions import (
    RecordNotFoundException,
    RecordAlreadyExistsException,
    FailedToUpdateException,
    InternalServerErrorException,
)

user_router = APIRouter()

@user_router.get("/searchByEmail", response_model=UserResponseSchema)
async def get_user_by_email(email: str, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.get_user_by_email(email)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get user "+str(e))

@user_router.get("/searchByPhone", response_model=UserResponseSchema)
async def get_user_by_phone(phone: str, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.find_user_by_phone(phone)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get user "+str(e))

@user_router.post("/", response_model=UserResponseSchema)
async def create_user(user: UserCreateSchema, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.create_user(user)
    except (RecordAlreadyExistsException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to create user "+str(e))

@user_router.get("/{user_id}", response_model=UserResponseSchema)
async def get_user_by_id(user_id: int, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.get_user_by_id(user_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get user "+str(e))
    
@user_router.get("/", response_model=list[UserResponseSchema])
async def get_all_users(skip: int = 0, limit: int = 10, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.get_all_users(skip, limit)
    except (RecordNotFoundException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get users "+str(e))

@user_router.put("/{user_id}", response_model=UserResponseSchema)
async def update_user(user_id: int, user: UserUpdateSchema, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.update_user(user_id, user.dict())
    except (RecordNotFoundException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to update user "+str(e))

@user_router.delete("/{user_id}")
async def delete_user(user_id: int, db: AsyncSession = Depends(get_db)):
    user_repo = UserRepository(db)
    user_service = UserService(user_repo)
    try:
        return await user_service.delete_user(user_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to delete user "+str(e))