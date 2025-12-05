// mobile-app/src/types/budget.ts
export interface BudgetResponse {
  id?: number;
  name: string;
  amount: number;
  currency: string;
  period: string;
  start_date: string;
  end_date: string;
  category_id: number;
  user_id: number;
  is_active?: boolean;
}

export interface BudgetCreate {
  id?: number;
  name: string;
  amount: number;
  currency: string;
  period: string;
  start_date: string;
  end_date: string;
  category_id: number;
  user_id: number;
  is_active?: boolean;
}

export interface BudgetUpdate {
  id?: number;
  name: string;
  amount: number;
  currency: string;
  period: string;
  start_date: string;
  end_date: string;
  category_id: number;
  user_id: number;
  is_active?: boolean;
}