from datetime import datetime
from sqlalchemy import select
from app.schemas.category_schema import CategoryCreateSchema, CategoryUpdateSchema
from app.models.category_model import CategoryModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)

class CategoryRepository:
    def __init__(self, db):
        self.db = db

    async def get_all_categories(self):
        result = await self.db.execute(select(CategoryModel))
        if not result:
            return []
            # raise RecordNotFoundException("No category records found")
        return result.scalars().all()

    async def get_category_by_id(self, category_id: int):
        result = await self.db.execute(
            select(CategoryModel).where(CategoryModel.id == category_id)
        )
        category = result.scalars().first()
        if not category:
            raise RecordNotFoundException("Category not found")
        return category

    async def create_category(self, category: CategoryCreateSchema) -> CategoryModel:
        db_category = CategoryModel(**category.dict(exclude_unset=True))

        try:
            self.db.add(db_category)
            await self.db.commit()
            await self.db.refresh(db_category)
            return db_category
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_category(
        self, category_id: int, category_data: CategoryUpdateSchema
    ) -> CategoryModel:
        result = await self.db.execute(
            select(CategoryModel).where(CategoryModel.id == category_id)
        )
        category = result.scalars().first()

        if not category:
            raise RecordNotFoundException("Category not found")

        update_data = category_data.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(category, key, value)

        try:
            category.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(category)
            return category
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_category(self, category_id: int):
        result = await self.db.execute(
            select(CategoryModel).where(CategoryModel.id == category_id)
        )
        category = result.scalars().first()
        if not category:
            raise RecordNotFoundException("Category not found")

        try:
            category.is_active = False
            category.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(category)
            return category
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
