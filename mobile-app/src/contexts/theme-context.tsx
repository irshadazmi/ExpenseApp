// mobile-app/src/contexts/theme-context.tsx
import React, {
  createContext,
  useContext,
  useEffect,
  useState,
} from "react";

import AsyncStorage from "@react-native-async-storage/async-storage";
import { useColorScheme } from "react-native";
import { getColors } from "@/constants/theme";

/* ======================================================
    TYPES
====================================================== */

export type ThemeMode = "light" | "dark" | "system";

type ThemeContextType = {
  mode: ThemeMode;
  resolvedMode: "light" | "dark";
  colors: ReturnType<typeof getColors>;
  toggle: () => Promise<void>;
  setMode: (mode: ThemeMode) => Promise<void>;
};

/* ======================================================
    CONTEXT
====================================================== */

const ThemeContext = createContext<ThemeContextType | null>(
  null
);

/* ======================================================
    PROVIDER
====================================================== */

export const ThemeProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const systemScheme = useColorScheme();

  const [mode, setModeState] =
    useState<ThemeMode>("system");

  /* ---------- LOAD SAVED MODE ---------- */
  useEffect(() => {
    (async () => {
      const saved = await AsyncStorage.getItem(
        "themeMode"
      );

      if (
        saved === "light" ||
        saved === "dark" ||
        saved === "system"
      ) {
        setModeState(saved);
      }
    })();
  }, []);

  /* ---------- RESOLVE FINAL MODE ---------- */
  const resolvedMode: "light" | "dark" =
    mode === "system"
      ? systemScheme === "dark"
        ? "dark"
        : "light"
      : mode;

  /* ---------- TOGGLE (Header button) ---------- */
  const toggle = async () => {
    const next =
      mode === "light"
        ? "dark"
        : mode === "dark"
        ? "system"
        : "light";

    setModeState(next);
    await AsyncStorage.setItem("themeMode", next);
  };

  /* ---------- SET MODE (Settings screen) ---------- */
  const setMode = async (next: ThemeMode) => {
    setModeState(next);
    await AsyncStorage.setItem("themeMode", next);
  };

  return (
    <ThemeContext.Provider
      value={{
        mode,
        resolvedMode,
        colors: getColors(resolvedMode),
        toggle,
        setMode,
      }}
    >
      {children}
    </ThemeContext.Provider>
  );
};

/* ======================================================
    HOOK
====================================================== */

export const useTheme = () => {
  const ctx = useContext(ThemeContext);

  if (!ctx)
    throw new Error(
      "useTheme must be used within ThemeProvider"
    );

  return ctx;
};
