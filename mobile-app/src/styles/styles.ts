// mobile-app/src/styles/styles.ts
import { getColors } from "@/constants/theme";
import { StyleSheet } from "react-native";
import { useTheme } from "@/contexts/theme-context";

export const useStyles = () => {
  const { resolvedMode } = useTheme();   // ✅ use resolvedMode
  const COLORS = getColors(resolvedMode);

  const SURFACE = COLORS.surface;
  const SURFACE_SOFT = COLORS.secondary;


  const OVERLAY = COLORS.cardShadow;
  const SKELETON = COLORS.lightGray; // neutral skeleton

  const CHIP_BG = COLORS.card;
  const BAR_BG = COLORS.disabled;

  return StyleSheet.create({
    //  Layout
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

    //  Text
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

    //  Images / Media
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

    //  Inputs
    textInput: {
      height: 46,
      borderColor: COLORS.primary,
      borderWidth: 1.5,
      borderRadius: 5,
      paddingHorizontal: 10,
      backgroundColor: COLORS.card,
      color: COLORS.text,
      fontSize: 16,
      marginTop: 0,
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
      borderRadius: 0,
      paddingVertical: 10,
      paddingHorizontal: 10,
      backgroundColor: COLORS.card,
      justifyContent: "center",
      color: COLORS.text,
      fontSize: 16,
      marginVertical: 10,
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

    //  Buttons
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

    //  Dropdown & Picker
    dropdownWrapper: {
      height: 46,
      borderWidth: 1.5,
      borderColor: COLORS.primary,
      backgroundColor: COLORS.card,
      borderRadius: 0,
      paddingHorizontal: 10,
      justifyContent: "center",
      marginVertical: 10,
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

    //  Header
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

    //  List / Table
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

    //  Radio Buttons
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
      backgroundColor: COLORS.primary,
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

    //  Generic Card
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

    //  Tab Bar
    tabBarContainer: {
      flexDirection: "row",
      justifyContent: "space-around",
      height: 64,
      backgroundColor: COLORS.tabBg,   // ✅ solid color
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

    // Tab Bar – Icons & Badges
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

    //  Feedback List & Form
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
      fontWeight: "600",
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

    //  Custom Drawer
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

    //  DASHBOARD
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

    // Skeleton loaders
    skeletonBox: {
      borderRadius: 12,
      backgroundColor: COLORS.background,
      marginVertical: 8,
      opacity: 0.6,
    },

    // transactions list
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

    // dashboard
    value: {
      marginTop: 4,
      fontSize: 18,
      fontWeight: "700",
    },

    subValue: {
      fontSize: 12,
      opacity: 0.7,
    },

    // === DARK SAFE HELPERS ===
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

