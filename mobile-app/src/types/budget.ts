export interface BudgetResponse {
  id: number;
  name: string;               // already resolved by backend
  amount: number;
  currency: string;
  period: string;

  effective_from: string;
  effective_to?: string | null;

  category_id: number;
  user_id: number;
  is_active: boolean;

  version: number;
  created_at?: string;
  updated_at?: string | null;
}