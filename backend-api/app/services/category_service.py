from app.schemas.category_schema import CategoryCreateSchema, CategoryUpdateSchema

class CategoryService:
    def __init__(self, category_repository):
        self.category_repository = category_repository

    async def get_all_categories(self, skip: int = 0, limit: int = 10):
        return await self.category_repository.get_all_categories(skip, limit)
    
    async def get_category_by_id(self, category_id: int):
        return await self.category_repository.get_category_by_id(category_id)
    
    async def create_category(self, category: CategoryCreateSchema):
        category_dict = category.dict()
        return await self.category_repository.create_category(category_dict)
    
    async def update_category(self, category_id: int, category: CategoryUpdateSchema):
        category_dict = category.dict(exclude_unset=True)
        return self.category_repository.update_category(category_id, category_dict)
    
    async def delete_category(self, category_id: int):
        return await self.category_repository.delete_category(category_id)