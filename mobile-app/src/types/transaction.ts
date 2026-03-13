export interface TransactionResponse {
  id: number;
  description: string;
  amount: number;
  category_id: number;
  type: string;
  currency: string;
  user_id: number;
  transaction_date: string;   
  created_at: string;
  updated_at?: string | null;
}