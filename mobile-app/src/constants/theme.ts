// mobile-app/src/constants/theme.ts

import { Platform } from "react-native";

/* ======================================================
    SEMANTIC COLOR PALETTES
====================================================== */

/* ---------- LIGHT MODE ---------- */
const lightColors = {
  // Core brand
  primary: "#7F00FF",
  secondary: "#E1C3FD",

  // Feedback
  success: "#8BC34A",
  warning: "#FFC107",
  danger: "#EA4C68",
  info: "#007AFF",

  // Status aliases
  error: "#EA4C68",

  // Neutrals
  background: "#FFFFFF",
  surface: "#F7F7F7",
  card: "#FFFFFF",
  border: "#E0E0E0",
  divider: "#EFEFEF",
  disabled: "#A9C3F5",

  white: "#FFFFFF",
  lightGray: "#F7F7F7",

  // Typography
  text: "#292140",
  textSecondary: "#5A3D8C",
  textMuted: "#8884A5",
  textInverse: "#FFFFFF",

  // Effects
  cardShadow: "#B095D4",

  // Charts
  chartFill: "#333333",

  // Raw colors (rarely used, kept for backward compatibility)
  red: "#FF3B30",
  green: "#34C759",
  blue: "#007AFF",
  yellow: "#FFCC00",

  // Tab bar
  tabBg: "#6C5CE7",
  tabBorderTop: "#120420",
  tabActive: "#44E4FF",
  tabActiveAlt: "#FF3FBF",
  tabInactive: "#E0E0F5",

  // Badges
  badgeBg: "#FF4D8D",
  badgeText: "#FFFFFF",

  skeleton: '#f0f0f0',
};

/* ---------- DARK MODE ---------- */
const darkColors = {
  // Core brand
  primary: "#9D7BFF",
  secondary: "#1B132F",

  // Feedback
  success: "#9BE15D",
  warning: "#FFD54F",
  danger: "#FF5A74",
  info: "#0A84FF",

  // Status aliases
  error: "#FF5A74",

  // Neutrals
  background: "#151718",
  surface: "#1F1B2E",
  card: "#1F1B2E",
  border: "#3C3558",
  divider: "#332D49",
  disabled: "#44405A",

  white: "#000000",
  lightGray: "#2A2238",

  // Typography
  text: "#F5F3FF",
  textSecondary: "#B8B0E0",
  textMuted: "#9993C9",
  textInverse: "#000000",

  // Effects
  cardShadow: "#000000",

  // Charts
  chartFill: "#EAE8F7",

  // Raw colors
  red: "#FF453A",
  green: "#32D74B",
  blue: "#0A84FF",
  yellow: "#FFD60A",

  // Tab bar
  tabBg: "#1F154A",
  tabBorderTop: "#0F061B",
  tabActive: "#44E4FF",
  tabActiveAlt: "#FF3FBF",
  tabInactive: "#8882B9",

  // Badges
  badgeBg: "#FF4D8D",
  badgeText: "#FFFFFF",
  skeleton: '#f0f0f0',
};

/* ======================================================
    ACTIVE THEME PICKER
====================================================== */

export type ThemeMode = "light" | "dark";

export const getColors = (mode: ThemeMode) =>
  mode === "dark" ? darkColors : lightColors;

/**
 * Default export remains LIGHT colors so
 * existing imports continue to work:
 *
 *   import { COLORS } from "@/constants/theme";
 */
export const COLORS = lightColors;

/* ======================================================
    NAVIGATION TOKENS (React Navigation)
====================================================== */

export const Colors = {
  light: {
    tint: lightColors.primary,
    tabBg: lightColors.background,
    iconDefault: "#9265E7",
  },
  dark: {
    tint: darkColors.primary,
    tabBg: darkColors.background,
    iconDefault: darkColors.textSecondary,
  },
};

/* ======================================================
    FONT FAMILY TOKENS
====================================================== */

export const Fonts = Platform.select({
  ios: {
    sans: "system-ui",
    serif: "ui-serif",
    rounded: "ui-rounded",
    mono: "ui-monospace",
  },
  default: {
    sans: "normal",
    serif: "serif",
    rounded: "normal",
    mono: "monospace",
  },
  web: {
    sans:
      "system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif",
    serif: "Georgia, 'Times New Roman', serif",
    rounded:
      "'SF Pro Rounded', 'Hiragino Maru Gothic ProN', Meiryo, 'MS PGothic', sans-serif",
    mono:
      "SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace",
  },
});
