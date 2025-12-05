import { Platform } from "react-native";

/* ======================================================
    BASE COLOR PALETTE (Merged from COLORS.ts)
====================================================== */

export const COLORS = {
  primary: "#7F00FF",
  secondary: "#E1C3fd",
  lightPurple: "#efc3f8ff",
  lightGray: "#F7F7F7",
  white: "#FFFFFF",

  disabled: "#A9C3F5",

  text: "#292140",
  textSecondary: "#5A3D8C",

  cardShadow: "#B095D4",

  danger: "#EA4C68",
  success: "#8BC34A",
  warning: "#FFC107",

  red: "#FF3B30",
  green: "#34C759",
  blue: "#007AFF",
  yellow: "#FFCC00",

  chartFill: "#333333",

  // ========= Tab Bar =========
  tabBg: "#6c5ce7",
  tabBorderTop: "#120420",
  tabActive: "#44E4FF",
  tabActiveAlt: "#FF3FBF",
  tabInactive: "#E0E0F5",

  // ========= Badges =========
  badgeBg: "#FF4D8D",
  badgeText: "#FFFFFF",
};

/* ======================================================
    THEME TOKENS (Merged from theme.ts)
====================================================== */

export const Colors = {
  light: {
    tint: COLORS.primary,
    tabBg: COLORS.white,
    iconDefault: "#9265e7",
  },
  dark: {
    tint: COLORS.primary,
    tabBg: "#1f154a",
    iconDefault: COLORS.cardShadow,
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
