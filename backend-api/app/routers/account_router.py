# backend-api/app/routers/account_router.py
from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.account_repository import AccountRepository
from app.schemas.account_schema import AccountResponseSchema, AccountCreateSchema, AccountUpdateSchema
from app.services.account_service import AccountService
from app.utils.exceptions import FailedToUpdateException, InternalServerErrorException, RecordNotFoundException

account_router = APIRouter()

@account_router.get("/", response_model=list[AccountResponseSchema])
async def get_all_accounts(
    user_id: Optional[int] = None, 
    session: AsyncSession = Depends(get_db),
):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    return await account_service.get_all_accounts(user_id)
    
@account_router.get("/{account_id}", response_model=AccountResponseSchema)
async def get_account_by_id(account_id: int, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    return await account_service.get_account_by_id(account_id)
    
@account_router.post("/", response_model=AccountResponseSchema)
async def create_account(account: AccountCreateSchema, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    return await account_service.create_account(account)

@account_router.put("/{account_id}", response_model=AccountResponseSchema)
async def update_account(account_id: int, account: AccountUpdateSchema, db: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(db)
    account_service = AccountService(account_repo)
    try:
        return await account_service.update_account(account_id, account)
    except (RecordNotFoundException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to update account "+str(e))
    
@account_router.delete("/{account_id}")
async def delete_account(account_id: int, session: AsyncSession = Depends(get_db)):
    account_repo = AccountRepository(session)
    account_service = AccountService(account_repo)
    return await account_service.delete_account(account_id)