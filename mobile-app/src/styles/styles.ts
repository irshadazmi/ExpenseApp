import { COLORS } from "@/constants/COLORS";
import { StyleSheet } from "react-native";

const styles = StyleSheet.create({
  // ========= Layout =========
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: COLORS.secondary, // Softer background
    justifyContent: "center",
  },
  contentContainer: {
    paddingVertical: 24,
    paddingHorizontal: 24,
  },

  // ========= Text =========
  welcome: {
    fontSize: 26,
    fontWeight: "700",
    color: COLORS.primary,
    marginBottom: 12,
    textAlign: "center",
    letterSpacing: 0.5,
  },
  title: {
    fontSize: 22,
    fontWeight: "700",
    color: COLORS.text,
    marginBottom: 10,
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
    marginBottom: 4,
    color: COLORS.text,
  },
  errorText: {
    fontSize: 12,
    fontWeight: "500",
    color: COLORS.danger,
    marginBottom: 4,
  },

  // ========= Images / Media =========
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

  // ========= Inputs =========
  textInput: {
    height: 46,
    borderColor: COLORS.primary,
    borderWidth: 1.5,
    borderRadius: 0,
    paddingVertical: 10,
    paddingHorizontal: 10,
    backgroundColor: COLORS.white,
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
  dateInput: {
    height: 46,
    borderColor: COLORS.primary,
    borderWidth: 1.5,
    borderRadius: 0,
    paddingVertical: 10,
    paddingHorizontal: 10,
    backgroundColor: COLORS.white,
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

  // ========= Buttons =========
  button: {
    backgroundColor: COLORS.primary,
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
  buttonText: {
    color: COLORS.white,
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
    color: COLORS.white,
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
    color: COLORS.white,
    fontWeight: "600",
  },

  // ========= Dropdown & Picker =========
  dropdownWrapper: {
    height: 46,
    borderWidth: 1.5,
    borderColor: COLORS.primary,
    backgroundColor: COLORS.white,
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
    fontSize: 16,
    color: COLORS.text,
  },
  picker: {
    height: 48,
    width: "100%",
    color: COLORS.text,
  },

  // ========= Header =========
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
    color: COLORS.white,
    fontSize: 20,
    fontWeight: "700",
    letterSpacing: 1,
  },

  // ========= List / Table =========
  listHeader: {
    height: 46,
    flexDirection: "row",
    paddingVertical: 8,
    paddingHorizontal: 4,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: COLORS.primary,
    borderBottomWidth: 1,
    borderBottomColor: "#ccc",
  },
  listHeaderText: {
    fontSize: 16,
    fontWeight: "bold",
    textAlign: "right",
    color: COLORS.white,
  },
  listRow: {
    flexDirection: "row",
    paddingVertical: 10,
    paddingHorizontal: 4,
    alignItems: "center",
    borderBottomWidth: 1,
    borderBottomColor: "#eee",
    backgroundColor: "#F7F3FF",
  },
  listRowAlt: {
    backgroundColor: COLORS.lightPurple,
  },

  // ========= Radio Buttons =========
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
    backgroundColor: COLORS.white,
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

  // ========= Generic Card =========
  card: {
    backgroundColor: COLORS.white,
    borderRadius: 10,
    padding: 12,
    marginBottom: 10,
    elevation: 2,
    shadowColor: "#000",
    shadowOpacity: 0.1,
    shadowRadius: 4,
    shadowOffset: { width: 0, height: 2 },
  },

  // ========= Tab Bar =========
  tabBarContainer: {
    flexDirection: "row",
    justifyContent: "space-around",
    height: 64,
    backgroundColor: COLORS.tabBg, // dark brinjal
    borderTopWidth: 0,
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
    color: COLORS.white,
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
  badgeContainer: {
    position: "absolute",
    top: -6,
    right: -12,
    minWidth: 16,
    paddingHorizontal: 4,
    height: 16,
    borderRadius: 8,
    backgroundColor: COLORS.badgeBg ?? "#FF4D8D",
    alignItems: "center",
    justifyContent: "center",
  },
  badgeText: {
    fontSize: 10,
    color: COLORS.badgeText ?? "#FFFFFF",
    fontWeight: "700",
  },

  // ========= Feedback List & Form =========
  headerRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 12,
  },
  searchInput: {
    borderWidth: 1,
    borderColor: "#ddd",
    borderRadius: 8,
    paddingHorizontal: 10,
    paddingVertical: 8,
    marginBottom: 12,
    backgroundColor: "#fff",
  },
  sectionLabel: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: 4,
    color: COLORS.textSecondary,
  },
  chipsContainer: {
    flexDirection: "row",
    flexWrap: "wrap",
    marginBottom: 8,
  },
  chip: {
    borderWidth: 1,
    borderColor: COLORS.primary,
    borderRadius: 16,
    paddingHorizontal: 10,
    paddingVertical: 4,
    marginRight: 6,
    marginBottom: 6,
    backgroundColor: "#fff",
  },
  chipSelected: {
    backgroundColor: COLORS.primary,
  },
  chipText: {
    fontSize: 12,
    color: COLORS.primary,
  },
  chipTextSelected: {
    color: COLORS.white,
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
  description: {
    fontSize: 13,
    marginBottom: 8,
    color: COLORS.text,
  },
  metaRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginBottom: 8,
  },
  metaText: {
    fontSize: 11,
    color: "#666",
  },
  replyBox: {
    backgroundColor: "#F5F0FF",
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
    color: COLORS.white,
    fontWeight: "600",
  },
  editButton: {
    backgroundColor: "#3498db",
  },
  deleteButton: {
    backgroundColor: "#e74c3c",
  },
  replyButton: {
    backgroundColor: "#27ae60",
  },

  // ========= Custom Drawer =========
  drawer: {
    flex: 1,
  },
  backdrop: {
    flex: 1,
    backgroundColor: "#00000088",
  },
  drawerContainer: {
    backgroundColor: COLORS.white,
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
    backgroundColor: COLORS.tabBg,              // dark brinjal background
  },
  drawerItemText: {
    fontSize: 16,
    fontWeight: "600",
    color: COLORS.text,
  },
  drawerItemTextActive: {
    color: COLORS.tabActive,                    // neon pink/blue for active
  },
});

export default styles;
