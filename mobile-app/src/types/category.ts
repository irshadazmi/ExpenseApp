export interface CategoryResponse {
  id?: number;
  name: string;
  is_active?: boolean;
}

export interface CategoryCreate {
  id?: number;
  name: string;
  is_active?: boolean;
}

export interface CategoryUpdate {
  id: number;
  name: string;
  is_active?: boolean;
}