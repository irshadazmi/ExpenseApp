// mobile-app/src/types/category.ts
export interface CategoryResponse {
  id?: number;
  name: string;
  short_name?: string;
  is_active?: boolean;
}

export interface CategoryCreate {
  id?: number;
  name: string;
  short_name?: string;
  is_active?: boolean;
}

export interface CategoryUpdate {
  id: number;
  name: string;
  short_name?: string;
  is_active?: boolean;
}