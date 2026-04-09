// mobile-app/src/constants/theme.ts

import { Platform } from "react-native";

/* ======================================================
    SEMANTIC COLOR PALETTES
====================================================== */

/* ---------- LIGHT MODE ---------- */
export const lightColors = {
  primary: "#7F00FF",
  secondary: "#E1C3FD",

  success: "#8BC34A",
  warning: "#FFC107",
  danger: "#EA4C68",
  info: "#007AFF",
  error: "#EA4C68",

  appBackground: "#F6F2FF",
  background: "#F6F2FF",
  surface: "#E9E3FB",
  card: "#F0EBFC",
  border: "#D2C8F2",
  divider: "#EFEAFE",
  disabled: "#A9C3F5",

  white: "#FFFFFF",
  lightGray: "#F3EEFC",

  text: "#2A2143",
  legendText: "#1F1F1F",
  textSecondary: "#5A3D8C",
  textMuted: "#8884A5",
  textInverse: "#FFFFFF",

  cardShadow: "#B095D4",

  chartFill: "#333333",

  red: "#FF3B30",
  green: "#34C759",
  blue: "#007AFF",
  yellow: "#FFCC00",

  tabBg: "#181920",
  tabBorderTop: "#5A00B5",
  tabActive: "#44E4FF",
  tabActiveAlt: "#4CAF50",
  tabInactive: "#FFC0CB",

  badgeBg: "#FF4D8D",
  badgeText: "#FFFFFF",

  skeleton: "#f0f0f0",
};

/* ---------- DARK MODE ---------- */
export const darkColors = {
  primary: "#9D7BFF",
  secondary: "#1B132F",

  success: "#9BE15D",
  warning: "#FFD54F",
  danger: "#FF5A74",
  info: "#0A84FF",
  error: "#FF5A74",

  background: "#151718",
  surface: "#1F1B2E",
  card: "#1F1B2E",
  border: "#3C3558",
  divider: "#332D49",
  disabled: "#44405A",

  white: "#000000",
  lightGray: "#2A2238",

  text: "#F5F3FF",
  legendText: "#F5F3FF",
  textSecondary: "#B8B0E0",
  textMuted: "#9993C9",
  textInverse: "#000000",

  cardShadow: "#000000",

  chartFill: "#EAE8F7",

  red: "#FF453A",
  green: "#32D74B",
  blue: "#0A84FF",
  yellow: "#FFD60A",

  // tabBg: "#1A1A1A",
  // tabBorderTop: "#0F061B",
  // tabActive: "#44E4FF",
  // tabActiveAlt: "#FF3FBF",
  // tabInactive: "#8882B9",
  tabBg: "#181920",
  tabBorderTop: "#5A00B5",
  tabActive: "#44E4FF",
  tabActiveAlt: "#4CAF50",
  tabInactive: "#FFC0CB",

  badgeBg: "#FF4D8D",
  badgeText: "#FFFFFF",

  skeleton: "#f0f0f0",
};

/* ======================================================
    CHART COLORS
====================================================== */

export const CHART_COLORS = {
  violet: "#7C4DFF",
  teal: "#26A69A",
  coral: "#FF7043",
  blue: "#42A5F5",
  purple: "#AB47BC",
  amber: "#FFCA28",
  pink: "#EC407A",
  green: "#66BB6A",
  sky: "#29B6F6",
  peach: "#FF8A65",
};


/* ======================================================
    ACTIVE THEME PICKER
====================================================== */

export type ThemeMode = "light" | "dark";

export const getColors = (mode: ThemeMode) =>
  mode === "dark" ? darkColors : lightColors;

/* ======================================================
    NAVIGATION TOKENS
====================================================== */

export const Colors = {
  light: {
    tint: lightColors.primary,
    tabBg: lightColors.background,
    iconDefault: lightColors.textSecondary,
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
