from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.account_repository import AccountRepository
from app.schemas.account_schema import AccountResponseSchema
from app.services.account_service import AccountService
from app.utils.exceptions import InternalServerErrorException, RecordNotFoundException

account_router = APIRouter()

@account_router.get("/", response_model=list[AccountResponseSchema])
async def get_all_accounts(skip: int = 0, limit: int = 10, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    
    try:
        return await account_service.get_all_accounts(skip, limit)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get accounts "+str(e))
    
@account_router.get("/{account_id}", response_model=AccountResponseSchema)
async def get_account_by_id(account_id: int, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    
    try:
        return await account_service.get_account_by_id(account_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get account "+str(e))
    
@account_router.post("/", response_model=AccountResponseSchema)
async def create_account(account: AccountResponseSchema, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    
    try:
        return await account_service.create_account(account)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to create account "+str(e))
    
@account_router.delete("/{account_id}")
async def delete_account(account_id: int, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    
    try:
        return await account_service.delete_account(account_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to delete account "+str(e))