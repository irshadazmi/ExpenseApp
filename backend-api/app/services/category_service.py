from app.schemas.category_schema import CategoryCreateSchema, CategoryUpdateSchema

class CategoryService:
    def __init__(self, category_repository):
        self.category_repository = category_repository

    async def get_all_categories(self):
        return await self.category_repository.get_all_categories()
    
    async def get_category_by_id(self, category_id: int):
        return await self.category_repository.get_category_by_id(category_id)
    
    async def create_category(self, category_data: CategoryCreateSchema):
        category_dict = category_data.dict()
        return await self.category_repository.create_category(category_dict)
    
    async def update_category(self, category_id: int, category_data: CategoryUpdateSchema):
        category_dict = category_data.dict(exclude_unset=True)
        return self.category_repository.update_category(category_id, category_dict)
    
    async def delete_category(self, category_id: int):
        return await self.category_repository.delete_category(category_id)