// src/types/expense.ts
export interface ExpenseCreate {
  description: string;
  amount: number;        
  category_id: number;
  type: string;          // "Expense" | "Income" | "Transfer" (by convention)
  currency: string;      // "INR" | "USD" | "GBP" | "EUR"
  user_id: number;
  expense_date: string;  // ISO string, e.g. "2025-11-15T17:03:20.441Z"
}

export interface ExpenseUpdate {
  description?: string;
  amount?: number;
  category_id?: number;
  type?: string;
  currency?: string;
  user_id?: number;
  expense_date?: string;
}

export interface ExpenseResponse {
  id: number;
  description: string;
  amount: number;
  category_id: number;
  type: string;
  currency: string;
  user_id: number;
  expense_date: string;   
  created_at: string;
  updated_at?: string | null;
}
