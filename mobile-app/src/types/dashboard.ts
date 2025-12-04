// mobile-app/src/types/dashboard.ts
export interface DashboardSummaryResponse {
  total_budget: number;
  total_spent: number;
  remaining: number;
  percent_used: number;
}

export interface DashboardCategoryResponse {
  category_id: number;
  category_name: string;
  short_name: string;
  allocated_budget: number;
  spent_amount: number;
  remaining: number;
  percent_used: number;
  is_over_budget: boolean;
}

export interface DashboardAccountResponse {
  account_id: number;
  account_name?: string;
  balance?: number;
  total_spent: number;
}

export interface DashboardTransactionResponse {
  id: number;
  description: string;
  category_id: number;
  amount: number;
  type: string;
  expense_date: string;
}
