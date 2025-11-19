// src/types/auth.ts
export type UserResponse = {
  id: number;
  email: string;
  phone: string;
  role_id: number;
  is_active: boolean;
};

export type Token = {
  access_token: string;
  token_type: string;
};

export type AuthResponse = {
  user: UserResponse;
  token: Token;
};

export interface AuthRegisterSchema {
	email: string;
	password: string;
	confirm_password: string;
	phone: string;
	role_id: number;
	is_active: boolean;
}
