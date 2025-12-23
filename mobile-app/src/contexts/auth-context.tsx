// src/contexts/auth-context.tsx
import React, {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  ReactNode,
} from "react";
import AsyncStorage from "@react-native-async-storage/async-storage";

import { authService } from "@/services/auth-service";
import {
  AuthUser,
  AuthToken,
  LoginResponse,
  RegisterRequest,
  RegisterResponse,
} from "@/types/auth";

/* ======================================================
   STORAGE KEYS (must match config/api.ts)
====================================================== */

const STORAGE_KEY_USER = "@auth:user";
const STORAGE_KEY_TOKEN = "@auth:token";

/* ======================================================
   CONTEXT TYPES
====================================================== */

type AuthState = {
  user: AuthUser | null;
  token: AuthToken | null;
  isLoading: boolean;
  isAuthenticated: boolean;
};

type AuthContextValue = AuthState & {
  /* API-backed actions */
  loginWithCredentials: (email: string, password: string) => Promise<void>;
  registerWithCredentials: (payload: RegisterRequest) => Promise<RegisterResponse>;

  /* Apply externally obtained payloads */
  applyLogin: (payload: LoginResponse) => Promise<void>;
  applyRegister: (payload: RegisterResponse) => Promise<void>;

  /* Session helpers */
  logout: () => Promise<void>;
  updateUser: (partial: Partial<AuthUser>) => Promise<void>;
};

/* ======================================================
   CONTEXT
====================================================== */

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

/* ======================================================
   PROVIDER
====================================================== */

type AuthProviderProps = {
  children: ReactNode;
};

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [token, setToken] = useState<AuthToken | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  /* ======================================================
     BOOTSTRAP – restore session
  ====================================================== */

  useEffect(() => {
    const bootstrap = async () => {
      try {
        const [userJson, tokenJson] = await Promise.all([
          AsyncStorage.getItem(STORAGE_KEY_USER),
          AsyncStorage.getItem(STORAGE_KEY_TOKEN),
        ]);

        if (userJson) setUser(JSON.parse(userJson));
        if (tokenJson) setToken(JSON.parse(tokenJson));
      } catch (err) {
        console.error("[Auth] Failed to restore session", err);
        setUser(null);
        setToken(null);
      } finally {
        setIsLoading(false);
      }
    };

    bootstrap();
  }, []);

  /* ======================================================
     STORAGE SYNC
  ====================================================== */

  const persistSession = useCallback(
    async (nextUser: AuthUser | null, nextToken: AuthToken | null) => {
      try {
        if (nextUser && nextToken) {
          await Promise.all([
            AsyncStorage.setItem(STORAGE_KEY_USER, JSON.stringify(nextUser)),
            AsyncStorage.setItem(STORAGE_KEY_TOKEN, JSON.stringify(nextToken)),
          ]);
        } else {
          await Promise.all([
            AsyncStorage.removeItem(STORAGE_KEY_USER),
            AsyncStorage.removeItem(STORAGE_KEY_TOKEN),
          ]);
        }
      } catch (err) {
        console.error("[Auth] Failed to persist session", err);
      }
    },
    []
  );

  /* ======================================================
     APPLY PAYLOADS (NO API)
  ====================================================== */

  const applyLogin = useCallback(
    async (payload: LoginResponse) => {
      setUser(payload.user);
      setToken(payload.token);
      await persistSession(payload.user, payload.token);
    },
    [persistSession]
  );

  const applyRegister = useCallback(
    async (payload: RegisterResponse) => {
      setUser(payload.user);

      if (payload.token) {
        setToken(payload.token);
        await persistSession(payload.user, payload.token);
      } else {
        // Registration without auto-login
        await persistSession(payload.user, null);
      }
    },
    [persistSession]
  );

  /* ======================================================
     API-BACKED ACTIONS
  ====================================================== */

  const loginWithCredentials = useCallback(
    async (email: string, password: string) => {
      const res = await authService.login(email, password);
      await applyLogin(res);
    },
    [applyLogin]
  );

  const registerWithCredentials = useCallback(
    async (payload: RegisterRequest) => {
      const res = await authService.register(payload);
      await applyRegister(res);
      return res; // important for clinic/patient creation flow
    },
    [applyRegister]
  );

  /* ======================================================
     LOGOUT
  ====================================================== */

  const logout = useCallback(async () => {
    setUser(null);
    setToken(null);
    await persistSession(null, null);
  }, [persistSession]);

  /* ======================================================
     UPDATE USER (LOCAL ONLY)
  ====================================================== */

  const updateUser = useCallback(async (partial: Partial<AuthUser>) => {
    setUser((prev) => {
      if (!prev) return prev;
      const merged = { ...prev, ...partial };
      AsyncStorage.setItem(STORAGE_KEY_USER, JSON.stringify(merged)).catch(
        (err) => console.error("[Auth] Failed to update user", err)
      );
      return merged;
    });
  }, []);

  /* ======================================================
     CONTEXT VALUE
  ====================================================== */

  const value: AuthContextValue = useMemo(
    () => ({
      user,
      token,
      isLoading,
      isAuthenticated: !!user && !!token?.access_token,
      loginWithCredentials,
      registerWithCredentials,
      applyLogin,
      applyRegister,
      logout,
      updateUser,
    }),
    [
      user,
      token,
      isLoading,
      loginWithCredentials,
      registerWithCredentials,
      applyLogin,
      applyRegister,
      logout,
      updateUser,
    ]
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

/* ======================================================
   HOOK
====================================================== */

export const useAuth = (): AuthContextValue => {
  const ctx = useContext(AuthContext);
  if (!ctx) {
    throw new Error("useAuth must be used within AuthProvider");
  }
  return ctx;
};
