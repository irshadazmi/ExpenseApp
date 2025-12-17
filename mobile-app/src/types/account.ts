// mobile-app/src/types/account.ts
export interface AccountResponse {
  id?: number;
  name: string;
  type: string;
  balance: number;
  currency: string;
  is_active?: boolean;
}

export interface AccountCreate {
  id?: number;
  name: string;
  type: string;
  balance: number;
  currency: string;
  is_active?: boolean;
}

export interface AccountUpdate {
  id?: number;
  name: string;
  type: string;
  balance: number;
  currency: string;
  is_active?: boolean;
}