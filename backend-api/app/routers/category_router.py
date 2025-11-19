from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.category_repository import CategoryRepository
from app.schemas.category_schema import CategoryResponseSchema
from app.services.category_service import CategoryService
from app.utils.exceptions import InternalServerErrorException, RecordNotFoundException

category_router = APIRouter()

@category_router.get("/", response_model=list[CategoryResponseSchema])
async def get_all_categories(skip: int = 0, limit: int = 10, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    
    try:
        return await category_service.get_all_categories(skip, limit)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get categories "+str(e))
    
@category_router.get("/{category_id}", response_model=CategoryResponseSchema)
async def get_category_by_id(category_id: int, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    
    try:
        return await category_service.get_category_by_id(category_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get category "+str(e))
    
@category_router.post("/", response_model=CategoryResponseSchema)
async def create_category(category: CategoryResponseSchema, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    
    try:
        return await category_service.create_category(category)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to create category "+str(e))
    
@category_router.delete("/{category_id}")
async def delete_category(category_id: int, session: AsyncSession = Depends(get_db)):
    category_repo = CategoryRepository(session)
    category_service = CategoryService(category_repo)
    
    try:
        return await category_service.delete_category(category_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to delete category "+str(e))