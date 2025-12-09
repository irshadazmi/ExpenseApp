import { getColors } from "@/constants/theme";
import { StyleSheet } from "react-native";
import { useTheme } from "@/contexts/theme-context";

export const useStyles = () => {
  const { resolvedMode } = useTheme();
  const COLORS = getColors(resolvedMode);

  const SURFACE = COLORS.surface;
  const SURFACE_SOFT = COLORS.secondary;

  const OVERLAY = COLORS.cardShadow;
  const SKELETON = COLORS.lightGray;

  const CHIP_BG = COLORS.card;
  const BAR_BG = COLORS.disabled;

  // ===================================================
  // BULLET-PROOF INPUT BASE ✅
  // ===================================================
  const INPUT_BASE = {
    backgroundColor: COLORS.card,
    color: COLORS.text,               // ✅ Always visible in dark mode
    borderColor: COLORS.primary,
    borderWidth: 1.5,
    shadowColor: COLORS.cardShadow,
    shadowOpacity: 0.1,
    shadowOffset: { width: 0, height: 1 },
    shadowRadius: 2,
    elevation: 1,
  };

  return StyleSheet.create({
    // ===================================================
    // LAYOUT
    // ===================================================
    container: {
      flex: 1,
      padding: 10,
      backgroundColor: SURFACE_SOFT,
      justifyContent: "center",
    },
    contentContainer: {
      paddingVertical: 0,
      paddingHorizontal: 0,
    },
    formContainer: {
      flex: 1,
      padding: 10,
      paddingBottom: 120,
      backgroundColor: SURFACE_SOFT,
    },

    // ===================================================
    // TEXT
    // ===================================================
    welcome: {
      fontSize: 26,
      fontWeight: "700",
      color: COLORS.primary,
      marginBottom: 12,
      letterSpacing: 0.5,
    },
    title: {
      fontSize: 22,
      fontWeight: "700",
      color: COLORS.text,
      marginBottom: 10,
      textAlign: "center",
    },
    description: {
      fontSize: 16,
      marginBottom: 8,
      color: COLORS.lightGray,
    },
    text: {
      fontSize: 16,
      color: COLORS.textSecondary,
      marginVertical: 8,
      lineHeight: 24,
    },
    link: {
      color: COLORS.primary,
      textDecorationLine: "underline",
      textAlign: "center",
    },
    label: {
      fontSize: 14,
      marginHorizontal: 0,
      marginTop: 8,
      paddingBottom: 10,
      color: COLORS.text,
    },
    errorText: {
      fontSize: 12,
      fontWeight: "500",
      color: COLORS.danger,
      marginBottom: 4,
    },

    // ===================================================
    // MEDIA
    // ===================================================
    image: {
      width: 240,
      height: 240,
      marginBottom: 32,
      alignSelf: "center",
    },
    logo: {
      width: 280,
      height: 280,
    },

    // ===================================================
    // INPUTS ✅ BULLETPROOF
    // ===================================================
    textInput: {
      ...INPUT_BASE,
      height: 46,
      borderRadius: 5,
      paddingHorizontal: 10,
      fontSize: 16,
      marginTop: 0,
      marginBottom: 10,
    },

    dateInput: {
      ...INPUT_BASE,
      height: 46,
      borderRadius: 0,
      paddingVertical: 10,
      paddingHorizontal: 10,
      justifyContent: "center",
      fontSize: 16,
      marginVertical: 10,
      marginBottom: 10,
    },

    dateText: {
      color: COLORS.text,
      fontSize: 16,
    },

    searchInput: {
      backgroundColor: COLORS.card,
      color: COLORS.text,
      borderColor: COLORS.border,
      borderWidth: 1,
      borderRadius: 8,
      paddingHorizontal: 10,
      paddingVertical: 8,
      marginBottom: 12,
    },

    // ===================================================
    // BUTTONS
    // ===================================================
    button: {
      backgroundColor: COLORS.primary,
      paddingVertical: 10,
      paddingHorizontal: 10,
      borderRadius: 5,
      marginVertical: 10,
      marginBottom: 10,
      alignItems: "center",
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.15,
      shadowOffset: { width: 0, height: 2 },
      shadowRadius: 6,
      elevation: 2,
    },
    buttonText: {
      color: COLORS.badgeText,
      fontSize: 17,
      fontWeight: "600",
      letterSpacing: 0.5,
    },
    disabledButton: {
      backgroundColor: COLORS.disabled,
      paddingVertical: 10,
      paddingHorizontal: 10,
      borderRadius: 0,
      marginVertical: 10,
      marginBottom: 10,
      alignItems: "center",
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.15,
      shadowOffset: { width: 0, height: 2 },
      shadowRadius: 6,
      elevation: 2,
    },
    disabledButtonText: {
      color: COLORS.badgeText,
      fontSize: 17,
      fontWeight: "600",
      letterSpacing: 0.5,
    },
    smallButton: {
      paddingHorizontal: 10,
      paddingVertical: 6,
      borderRadius: 8,
      backgroundColor: COLORS.primary,
    },
    smallButtonText: {
      fontSize: 12,
      color: COLORS.badgeText,
      fontWeight: "600",
    },

    // ===================================================
    // DROPDOWN / PICKER
    // ===================================================
    dropdownWrapper: {
      ...INPUT_BASE,
      height: 46,
      borderRadius: 0,
      paddingHorizontal: 10,
      justifyContent: "center",
      marginVertical: 10,
      marginBottom: 10,
    },
    dropdown: {
      borderWidth: 0,
      margin: 0,
      padding: 0,
      backgroundColor: "transparent",
    },
    dropdownText: {
      fontSize: 12,
      color: COLORS.text,
    },
    picker: {
      height: 48,
      width: "100%",
      color: COLORS.text,
    },

    // ===================================================
    // HEADER
    // ===================================================
    headerContainer: {
      width: "100%",
      height: 56,
      backgroundColor: COLORS.primary,
      justifyContent: "center",
      alignItems: "center",
      elevation: 5,
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.15,
      shadowOffset: { width: 0, height: 2 },
      shadowRadius: 6,
    },
    headerText: {
      color: COLORS.badgeText,
      fontSize: 20,
      fontWeight: "700",
      letterSpacing: 1,
    },

    // ===================================================
    // LISTS
    // ===================================================
    listHeader: {
      height: 46,
      flexDirection: "row",
      paddingVertical: 8,
      paddingHorizontal: 4,
      justifyContent: "center",
      alignItems: "center",
      backgroundColor: COLORS.primary,
      borderBottomWidth: 1,
      borderBottomColor: COLORS.border,
    },
    listHeaderText: {
      fontSize: 16,
      fontWeight: "bold",
      textAlign: "right",
      color: COLORS.badgeText,
    },
    listRow: {
      flexDirection: "row",
      paddingVertical: 10,
      paddingHorizontal: 4,
      alignItems: "center",
      borderBottomWidth: 1,
      borderBottomColor: COLORS.border,
      backgroundColor: SURFACE,
    },
    listRowAlt: {
      backgroundColor: COLORS.lightGray,
    },

    // ===================================================
    // GENERIC CARD
    // ===================================================
    card: {
      backgroundColor: SURFACE,
      borderRadius: 10,
      padding: 12,
      marginBottom: 10,
      elevation: 2,
      shadowColor: OVERLAY,
      shadowOpacity: 0.1,
      shadowRadius: 4,
      shadowOffset: { width: 0, height: 2 },
    },

    // ===================================================
    // TAB BAR
    // ===================================================
    tabBarContainer: {
      flexDirection: "row",
      justifyContent: "space-around",
      height: 64,
      backgroundColor: COLORS.tabBg,
      borderTopWidth: 1,
      borderTopColor: COLORS.tabBorderTop,
      shadowColor: COLORS.cardShadow,
      shadowOffset: { width: 0, height: -4 },
      shadowOpacity: 0.25,
      shadowRadius: 12,
      elevation: 10,
    },
    tabItem: {
      flex: 1,
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: 6,
    },
    tabLabel: {
      fontSize: 12,
      marginTop: 2,
    },
    tabBarTab: {
      flex: 1,
      justifyContent: "center",
      alignItems: "center",
    },
    tabBarText: {
      color: COLORS.badgeText,
      fontWeight: "600",
      fontSize: 14,
      letterSpacing: 0.5,
    },

    // ===================================================
    // HELPERS
    // ===================================================
    skeleton: {
      borderRadius: 12,
      backgroundColor: SKELETON,
      marginVertical: 8,
      opacity: 0.4,
    },
    chartSurface: {
      backgroundColor: SURFACE,
    },
    usageLabelRow: {
      flexDirection: "row",
      justifyContent: "space-between",
    },
  });
};
