// mobile-app/src/types/budget.ts

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

/* =========================
   CREATE
========================= */

export interface BudgetCreate {
  amount: number;
  currency: string;     // "INR"
  period: string;       // "Monthly"
  effective_from: string;
  effective_to?: string | null;
  category_id: number;
  user_id: number;
  is_active?: boolean;
}

/* =========================
   UPDATE (PARTIAL)
========================= */

export type BudgetUpdate = Partial<
  Pick<
    BudgetResponse,
    | "amount"
    | "effective_from"
    | "effective_to"
    | "is_active"
  >
>;

export type BudgetSnapshotItem = {
  id: number;
  name: string;
  amount: number;
  category_id: number | null;
};

export type SaveAllBudgetsPayload = {
  user_id: number;
  budgets: BudgetSnapshotItem[];
};

