// src/types/auth.ts

/* ======================================================
   AUTH TYPES – aligned with FastAPI models & responses
====================================================== */

export type AuthUser = {
  id: number;
  email: string;
  phone: string | null;
  role_id: number;
  is_active: boolean;
};

/**
 * Payload sent from mobile app → FastAPI when registering a new user.
 * Matches backend RegisterSchema.
 */
export type RegisterRequest = {
  email: string;
  password: string;
  confirm_password: string; // ✅ added
  phone: string;
  role_id: number;
};

/**
 * Shape of the user object FastAPI returns after successful registration.
 */
export type RegisterResponseUser = AuthUser;

/**
 * Auth token returned by FastAPI.
 */
export type AuthToken = {
  access_token: string;
  token_type: "bearer";
};

/**
 * Login response from FastAPI.
 */
export type LoginResponse = {
  user: AuthUser;
  token: AuthToken;
};

/**
 * Register response (token optional if backend auto-logins).
 */
export type RegisterResponse = {
  user: RegisterResponseUser;
  token?: AuthToken;
};
