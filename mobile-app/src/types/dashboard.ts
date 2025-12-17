// mobile-app/src/types/dashboard.ts

export type RiskLevel =
  | "under_budget"
  | "on_track"
  | "over_budget";

/* ======================================================
   SUMMARY
====================================================== */

export interface DashboardSummary {
  totals: {
    budget: number;
    spent: number;
    earning: number;
    remaining: number;
    usage_percent: number;
    projected_usage?: number; // Phase-4 (optional)
  };

  burn_rate: {
    daily_spend: number;
    daily_budget: number;
    risk: RiskLevel;
  };

  period: {
    year: number;
    month?: number | null;
    days_elapsed: number;
    days_in_period: number;
  };
}

/* ======================================================
   CATEGORY REPORT
====================================================== */

export interface CategoryReportItem {
  category_id: number;
  category_name: string;
  short_name: string;
  budget: number;
  spent: number;
  remaining?: number | null;
  usage_percent?: number | null;

  // Phase-4 forecasting
  projected_spend?: number;
  will_exceed?: boolean;
}

/* ======================================================
   RECENT TRANSACTIONS
====================================================== */

export interface RecentTransaction {
  id: number;
  description: string;
  amount: number;
  type: "Expense" | "Income";
  category: string;
  transaction_date: string;
}

/* ======================================================
   ACCOUNTS
====================================================== */

export interface DashboardAccount {
  id: number;
  name: string;
  type: string;
  balance: number;
  currency: string;
}
