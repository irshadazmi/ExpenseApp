# backend-api/app/routers/category_router.py
from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.category_repository import CategoryRepository
from app.schemas.category_schema import CategoryResponseSchema, CategoryCreateSchema, CategoryUpdateSchema
from app.services.category_service import CategoryService
from app.utils.exceptions import FailedToUpdateException, InternalServerErrorException, RecordNotFoundException

category_router = APIRouter()

@category_router.get("/", response_model=list[CategoryResponseSchema])
async def get_all_categories(session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    return await category_service.get_all_categories()
    
@category_router.get("/{category_id}", response_model=CategoryResponseSchema)
async def get_category_by_id(category_id: int, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    return await category_service.get_category_by_id(category_id)
    
@category_router.post("/", response_model=CategoryResponseSchema)
async def create_category(category: CategoryCreateSchema, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    return await category_service.create_category(category)

@category_router.put("/{category_id}", response_model=CategoryResponseSchema)
async def update_category(category_id: int, category: CategoryUpdateSchema, db: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(db)
    category_service = CategoryService(category_repo)
    try:
        return await category_service.update_category(category_id, category)
    except (RecordNotFoundException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to update category "+str(e))
    
@category_router.delete("/{category_id}")
async def delete_category(category_id: int, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    return await category_service.delete_category(category_id)