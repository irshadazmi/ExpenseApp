// mobile-app/src/styles/styles.ts
import { StyleSheet } from "react-native";
import { getColors } from "@/constants/theme";
import { useTheme } from "@/contexts/theme-context";

export const useStyles = () => {
  const { resolvedMode } = useTheme();
  const COLORS = getColors(resolvedMode);

  const SURFACE = COLORS.surface;
  const SURFACE_SOFT = COLORS.background;
  const OVERLAY = COLORS.cardShadow;
  const SKELETON = COLORS.skeleton;
  const CHIP_BG = COLORS.card;
  const BAR_BG = COLORS.disabled;

  return StyleSheet.create({
    /* ========== LAYOUT ========== */
    container: {
      flex: 1,
      padding: 10,
      backgroundColor: SURFACE_SOFT,
      marginTop: 0,
      textAlign: "left"
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

    /* ========== TEXT ========== */
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
      textAlign: "left",
    },
    description: {
      fontSize: 16,
      marginBottom: 8,
      color: COLORS.textSecondary,
      textAlign: "center",
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
      marginTop: 8,
      paddingBottom: 10,
      color: COLORS.text,
    },
    mutedText: {
      fontSize: 13,
      color: COLORS.textMuted,
      textAlign: "center",
    },
    errorText: {
      fontSize: 12,
      fontWeight: "500",
      color: COLORS.danger,
      marginBottom: 4,
    },

    /* ========== MEDIA ========== */
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

    /* ========== INPUTS ========== */
    textInput: {
      height: 46,
      borderColor: COLORS.primary,
      borderWidth: 1.5,
      borderRadius: 6,
      paddingHorizontal: 10,
      backgroundColor: COLORS.card,
      color: COLORS.text,
      fontSize: 16,
      marginBottom: 10,
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.1,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 2,
      elevation: 1,
    },
    dateInput: {
      height: 46,
      borderColor: COLORS.primary,
      borderWidth: 1.5,
      borderRadius: 6,
      paddingVertical: 10,
      paddingHorizontal: 10,
      backgroundColor: COLORS.card,
      justifyContent: "center",
      color: COLORS.text,
      fontSize: 16,
      marginBottom: 10,
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.1,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 2,
      elevation: 1,
    },
    dateText: {
      color: COLORS.text,
      fontSize: 16,
    },

    /* ========== BUTTONS ========== */

    button: {
      backgroundColor: COLORS.primary,
      paddingVertical: 10,
      paddingHorizontal: 12,
      borderRadius: 6,
      marginVertical: 10,

      alignItems: "center",
      justifyContent: "center",

      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.15,
      shadowOffset: { width: 0, height: 2 },
      shadowRadius: 6,
      elevation: 2,
    },

    circularButton: {
      backgroundColor: COLORS.primary,
      width: 48,
      height: 48,
      borderRadius: 24,

      alignItems: "center",
      justifyContent: "center",

      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.15,
      shadowOffset: { width: 0, height: 2 },
      shadowRadius: 6,
      elevation: 2,
    },

    smallButton: {
      backgroundColor: COLORS.primary,
      paddingHorizontal: 14,
      paddingVertical: 6,
      borderRadius: 8,

      alignItems: "center",
      justifyContent: "center",

      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.12,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 4,
      elevation: 1,
    },

    otpButton: {
      backgroundColor: COLORS.primary,
      height: 48,
      minWidth: 70,
      paddingHorizontal: 14,
      borderRadius: 24,

      alignItems: "center",
      justifyContent: "center",

      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.15,
      shadowOffset: { width: 0, height: 2 },
      shadowRadius: 6,
      elevation: 2,
    },

    disabledButton: {
      backgroundColor: COLORS.disabled,

      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.1,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 3,
      elevation: 1,
    },

    buttonText: {
      color: COLORS.badgeText,
      fontSize: 16,
      fontWeight: "600",
      letterSpacing: 0.4,
    },

    smallButtonText: {
      color: COLORS.badgeText,
      fontSize: 14,
      fontWeight: "600",
    },

    disabledButtonText: {
      color: COLORS.badgeText,
      opacity: 0.7,
      fontSize: 14,
      fontWeight: "600",
    },

    /* ========== DROPDOWN & PICKER ========== */
    dropdownWrapper: {
      height: 46,
      borderWidth: 1.5,
      borderColor: COLORS.primary,
      backgroundColor: COLORS.card,
      borderRadius: 6,
      paddingHorizontal: 10,
      justifyContent: "center",
      marginBottom: 10,
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.1,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 2,
      elevation: 1,
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

    /* ========== HEADER ========== */
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

    /* ========== LIST / TABLE ========== */
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

    /* ========== RADIO BUTTONS ========== */
    radioGroup: {
      flexDirection: "row",
      flexWrap: "wrap",
      marginVertical: 8,
    },
    radioOption: {
      flexDirection: "row",
      alignItems: "center",
      marginRight: 16,
      marginBottom: 8,
    },
    radioOuter: {
      width: 20,
      height: 20,
      borderRadius: 10,
      borderWidth: 2,
      borderColor: COLORS.textSecondary,
      justifyContent: "center",
      alignItems: "center",
      backgroundColor: COLORS.card,
    },
    radioOuterSelected: {
      borderColor: COLORS.primary,
      backgroundColor: COLORS.primary,
    },
    radioInner: {
      width: 10,
      height: 10,
      borderRadius: 5,
      backgroundColor: COLORS.badgeText,
    },
    radioLabel: {
      marginLeft: 6,
      fontSize: 14,
      color: COLORS.textSecondary,
    },
    radioLabelSelected: {
      color: COLORS.primary,
      fontWeight: "600",
    },

    /* ========== GENERIC CARD ========== */
    card: {
      backgroundColor: SURFACE,
      borderRadius: 10,
      padding: 10,
      marginBottom: 10,
      elevation: 2,
      shadowColor: OVERLAY,
      shadowOpacity: 0.1,
      shadowRadius: 4,
      shadowOffset: { width: 0, height: 2 },
    },

    /* ========== TAB BAR ========== */
    tabBarContainer: {
      flexDirection: "row",
      justifyContent: "space-around",
      alignItems: "center",

      height: 64,
      paddingBottom: 6, // ✅ absorbs safe-area inset visually

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
    tabIconWrapper: {
      position: "relative",
      alignItems: "center",
      justifyContent: "center",
    },
    tabsBadgeContainer: {
      position: "absolute",
      top: -6,
      right: -12,
      minWidth: 16,
      paddingHorizontal: 4,
      height: 16,
      borderRadius: 8,
      backgroundColor: COLORS.badgeBg,
      alignItems: "center",
      justifyContent: "center",
    },
    tabsBadgeText: {
      fontSize: 10,
      color: COLORS.badgeText,
      fontWeight: "700",
    },

    dashboardBadgeContainer: {
      alignSelf: "center",
      backgroundColor: COLORS.primary,
      paddingHorizontal: 20,
      paddingVertical: 6,
      borderRadius: 25,
      marginBottom: 15,
    },
    dashboardBadgeText: {
      fontSize: 16,
      color: COLORS.badgeText,
      fontWeight: "700",
    },

    /* ========== FEEDBACK LIST / FORMS ========== */
    headerRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: 12,
    },
    searchInput: {
      borderWidth: 1,
      borderColor: COLORS.border,
      borderRadius: 8,
      paddingHorizontal: 10,
      paddingVertical: 8,
      marginBottom: 12,
      backgroundColor: COLORS.card,
      color: COLORS.text,
    },
    sectionLabel: {
      fontSize: 14,
      fontWeight: "600",
      marginBottom: 4,
      color: COLORS.textSecondary,
    },
    chipsContainer: {
      flexDirection: "row",
      alignItems: "center",
      marginBottom: 6,
    },

    chip: {
      height: 30,
      paddingHorizontal: 14,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: COLORS.primary,
      backgroundColor: CHIP_BG,
      alignItems: "center",
      justifyContent: "center",
      marginRight: 6,
      marginBottom: 4,
      shadowColor: COLORS.cardShadow,
      shadowOpacity: 0.08,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 2,
      elevation: 1,
    },
    chipSelected: {
      backgroundColor: COLORS.primary,
      borderColor: COLORS.primary,
    },
    chipText: {
      fontSize: 12,
      fontWeight: "600",
      color: COLORS.primary,
      letterSpacing: 0.5,
    },
    chipLabel: {
      marginRight: 6,
      marginBottom: 12,
      fontSize: 14,
      fontWeight: "700",
      color: COLORS.textSecondary,
    },
    chipTextSelected: {
      color: COLORS.badgeText,
      fontWeight: "700",
    },

    cardHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "flex-start",
      marginBottom: 6,
    },
    cardTitle: {
      fontSize: 16,
      fontWeight: "700",
      flex: 1,
      marginRight: 8,
      color: COLORS.text,
    },
    statusBadge: {
      paddingHorizontal: 8,
      paddingVertical: 4,
      borderRadius: 12,
      backgroundColor: COLORS.secondary,
    },
    statusText: {
      fontSize: 10,
      fontWeight: "700",
      color: COLORS.textSecondary,
    },
    issueType: {
      fontSize: 13,
      fontWeight: "600",
      marginBottom: 4,
      color: COLORS.textSecondary,
    },
    metaRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginBottom: 8,
    },
    metaText: {
      fontSize: 11,
      color: COLORS.textSecondary,
    },
    replyBox: {
      backgroundColor: SURFACE_SOFT,
      borderRadius: 8,
      padding: 8,
      marginBottom: 8,
    },
    replyLabel: {
      fontSize: 12,
      fontWeight: "600",
      marginBottom: 2,
      color: COLORS.textSecondary,
    },
    replyText: {
      fontSize: 12,
      color: COLORS.text,
    },
    actionsRow: {
      flexDirection: "row",
      justifyContent: "flex-end",
      flexWrap: "wrap",
      gap: 8,
    } as any,
    actionButton: {
      paddingHorizontal: 10,
      paddingVertical: 6,
      borderRadius: 6,
      marginLeft: 8,
    },
    actionButtonText: {
      fontSize: 12,
      color: COLORS.badgeText,
      fontWeight: "600",
    },
    editButton: {
      backgroundColor: COLORS.blue,
    },
    deleteButton: {
      backgroundColor: COLORS.danger,
    },
    replyButton: {
      backgroundColor: COLORS.success,
    },

    /* ========== CUSTOM DRAWER ========== */
    drawer: {
      flex: 1,
    },
    backdrop: {
      flex: 1,
      backgroundColor: COLORS.cardShadow,
    },
    drawerContainer: {
      backgroundColor: SURFACE,
      padding: 20,
      marginTop: 60,
    },
    drawerItem: {
      flexDirection: "row",
      alignItems: "center",
      paddingVertical: 12,
      paddingHorizontal: 8,
      gap: 12,
      borderRadius: 8,
    },
    drawerItemActive: {
      backgroundColor: COLORS.tabBg,
    },
    drawerItemText: {
      fontSize: 16,
      fontWeight: "600",
      color: COLORS.text,
    },
    drawerItemTextActive: {
      color: COLORS.tabActive,
    },

    /* ========== DASHBOARD ========== */
    dashboardHeaderContainer: {
      padding: 10,
      width: "100%",
      backgroundColor: SURFACE_SOFT,
    },
    dashboardCardRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginBottom: 12,
    },
    dashboardUsageBox: {
      marginTop: 16,
      marginBottom: 8,
    },
    barBg: {
      height: 10,
      backgroundColor: BAR_BG,
      borderRadius: 10,
      marginTop: 6,
      overflow: "hidden",
    },
    barBgSmall: {
      height: 6,
      backgroundColor: BAR_BG,
      borderRadius: 6,
      marginTop: 4,
      overflow: "hidden",
    },
    barFill: {
      height: "100%",
      borderRadius: 10,
      backgroundColor: COLORS.primary,
    },
    dashboardChartBox: {
      marginTop: 20,
      marginBottom: 8,
      borderRadius: 12,
      backgroundColor: SURFACE,
      paddingVertical: 12,
      paddingHorizontal: 4,
      elevation: 2,
      shadowColor: OVERLAY,
      shadowOpacity: 0.08,
      shadowOffset: { width: 0, height: 1 },
      shadowRadius: 3,
    },
    dashboardChartTitle: {
      fontSize: 20,
      fontWeight: "700",
      marginBottom: 10,
      paddingHorizontal: 12,
      color: COLORS.text,
    },
    dashboardSection: {
      marginTop: 16,
      paddingHorizontal: 4,
    },
    dashboardCategoryRow: {
      marginTop: 10,
    },
    dashboardCategoryTitle: {
      fontSize: 13,
      fontWeight: "600",
      color: COLORS.text,
    },

    /* ========== SKELETONS ========== */
    skeletonBox: {
      borderRadius: 12,
      backgroundColor: COLORS.background,
      marginVertical: 8,
      opacity: 0.6,
    },
    skeleton: {
      borderRadius: 12,
      backgroundColor: SKELETON,
      marginVertical: 8,
      opacity: 0.4,
    },

    /* ========== TRANSACTIONS ========== */
    txnRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      padding: 12,
      borderBottomWidth: 1,
      borderColor: COLORS.border,
      backgroundColor: COLORS.card,
    },
    txnTitle: {
      fontSize: 14,
      fontWeight: "500",
      color: COLORS.text,
    },
    txnAmt: {
      fontWeight: "700",
      fontSize: 14,
    },

    /* ========== GENERIC NUMBERS ========== */
    value: {
      marginTop: 4,
      fontSize: 18,
      fontWeight: "700",
    },
    subValue: {
      fontSize: 12,
      opacity: 0.7,
    },

    /* ========== MISC ========== */
    chartSurface: {
      backgroundColor: SURFACE,
    },
    usageLabelRow: {
      flexDirection: "row",
      justifyContent: "space-between",
    },
  });
};
