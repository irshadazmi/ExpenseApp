# backend-api/app/routers/auth_router.py
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.ext.asyncio import AsyncSession
from app.schemas.auth_schema import (
    AuthRegisterSchema,
    AuthLoginSchema,
    AuthResponseSchema,
    AuthResultSchema,
    AuthUpdateSchema,
)
from app.services.auth_service import AuthService
from app.repositories.auth_repository import AuthRepository
from app.core.database import get_db
from app.utils.exceptions import (
    AuthenticationFailedException,
    RecordNotFoundException,
    RecordAlreadyExistsException,
    FailedToUpdateException,
    InternalServerErrorException,
)

auth_router = APIRouter()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/auth/login")


@auth_router.get("/me", response_model=AuthResultSchema)
async def get_me(
    token: str = Depends(oauth2_scheme), db: AsyncSession = Depends(get_db)
):
    auth_service = AuthService(AuthRepository(db))
    auth_result = await auth_service.get_current_user_from_token(token)
    if not auth_result:
        raise HTTPException(status_code=401, detail="Could not validate credentials")
    return auth_result


@auth_router.post(
    "/register", response_model=AuthResultSchema, status_code=status.HTTP_201_CREATED
)
async def register(user: AuthRegisterSchema, db: AsyncSession = Depends(get_db)):
    auth_repo = AuthRepository(db)
    auth_service = AuthService(auth_repo)
    try:
        return await auth_service.register_user(user)
    except (RecordAlreadyExistsException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to create user " + str(e))


@auth_router.post(
    "/login", response_model=AuthResultSchema, status_code=status.HTTP_200_OK
)
async def login(credentials: AuthLoginSchema, db: AsyncSession = Depends(get_db)):
    try:
        auth_service = AuthService(AuthRepository(db))
        return await auth_service.login_user(credentials)
    except AuthenticationFailedException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to login user " + str(e))


@auth_router.put("/{user_id}", response_model=AuthResultSchema)
async def update_user(
    user_id: int, user: AuthUpdateSchema, db: AsyncSession = Depends(get_db)
):
    auth_repo = AuthRepository(db)
    auth_service = AuthService(auth_repo)
    try:
        return await auth_service.update_user(user_id, user.dict())
    except (RecordNotFoundException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to update user " + str(e))
