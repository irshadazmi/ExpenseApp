// src/types/auth.ts
export type UserResponse = {
  id: number;
  full_name: string;
  email: string;
  phone: string;
  role_id: number;
  is_active: boolean;
};

export type Token = {
  access_token: string;
  token_type: string;

  // Optional – you can start populating these from backend later
  expires_at?: string;  // ISO string, e.g. "2025-11-21T10:20:00Z"
  expires_in?: number;  // seconds (if you prefer this on backend)
};

export type AuthResponse = {
  user: UserResponse;
  token: Token;
};

export interface AuthRegisterSchema {
  full_name: string;
  email: string;
  password: string;
  confirm_password: string;
  phone: string;
  role_id: number;
  is_active: boolean;
}
