import { COLORS } from "@/constants/COLORS";
import { StyleSheet } from "react-native";

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: COLORS.secondary,     // Softer background
    justifyContent: 'center',
    // paddingTop: 50
  },
  contentContainer: {
    paddingVertical: 24,
    paddingHorizontal: 24,
  },

  // Text styles
  welcome: {
    fontSize: 26,
    fontWeight: '700',
    color: COLORS.primary,                 // Use accent color
    marginBottom: 12,
    textAlign: 'center',
    letterSpacing: 0.5,
  },
  title: {
    fontSize: 22,
    fontWeight: '700',
    color: COLORS.text,
    marginBottom: 10,
    textAlign: 'center',
  },
  text: {
    fontSize: 16,
    color: COLORS.textSecondary,
    marginVertical: 8,
    lineHeight: 24,
  },
  description: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: 32
  },
  link: {
    color: COLORS.primary,
    textDecorationLine: 'underline',
    textAlign: 'center',
  },
  image: {
    width: 240,
    height: 240,
    marginBottom: 32,
    alignSelf: 'center',
  },
  logo: {
    width: 280,
    height: 280,
  },
  // Input styles
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
  // Button container
  button: {
    backgroundColor: COLORS.primary,
    paddingVertical: 10,
    paddingHorizontal: 10,
    borderRadius: 0,
    marginVertical: 10,
    marginBottom: 10,
    alignItems: 'center',
    shadowColor: COLORS.cardShadow,
    shadowOpacity: 0.15,
    shadowOffset: { width: 0, height: 2 },
    shadowRadius: 6,
    elevation: 2,
  },
  buttonText: {
    color: COLORS.white,
    fontSize: 17,
    fontWeight: '600',
    letterSpacing: 0.5,
  },
  disabledButton: {
    backgroundColor: COLORS.disabled,
    paddingVertical: 10,
    paddingHorizontal: 10,
    borderRadius: 0,
    marginVertical: 10,
    marginBottom: 10,
    alignItems: 'center',
    shadowColor: COLORS.cardShadow,
    shadowOpacity: 0.15,
    shadowOffset: { width: 0, height: 2 },
    shadowRadius: 6,
    elevation: 2,
  },
  disabledButtonText: {
    color: COLORS.white,
    fontSize: 17,
    fontWeight: '600',
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
    fontWeight: '600',
  },
  chip: {
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 999,
    borderWidth: 1,
    borderColor: COLORS.secondary,
    backgroundColor: COLORS.white,
  },
  label: {
    fontSize: 14,
    marginTop: 8,
    marginBottom: 4,
    color: COLORS.text,
  },
  errorText: {
    fontSize: 12,
    color: COLORS.danger,
    marginBottom: 4,
  },

  // Dropdown styles
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
    borderWidth: 0,   // 👈 REMOVE INTERNAL BORDER
    margin: 0,
    padding: 0,
    backgroundColor: "transparent",
  },
  dropdownText: {
    fontSize: 16,
    color: COLORS.text,
  },

  // Picker styles
  picker: {
    height: 48,
    width: "100%",
    color: COLORS.text,       // Dropdown text color
  },

  // List styles
  listHeader: {
    height: 46,
    flexDirection: 'row',
    paddingVertical: 8,
    paddingHorizontal: 4,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: COLORS.primary, // header background
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
  },

  listHeaderText: {
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: "right",
    color: COLORS.white, // <-- move text color here
  },

  listRow: {
    flexDirection: 'row',
    paddingVertical: 10,
    paddingHorizontal: 4,
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
    backgroundColor: '#F7F3FF',
  },

  listRowAlt: {
    backgroundColor: COLORS.lightPurple,
  },

  // Radio button styles
  radioGroup: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginVertical: 8,
  },

  radioOption: {
    flexDirection: 'row',
    alignItems: 'center',
    marginRight: 16,
    marginBottom: 8,
  },

  radioOuter: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 2,
    borderColor: COLORS.textSecondary,
    justifyContent: 'center',
    alignItems: 'center',
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
    fontWeight: '600',
  },

  // Generic card/view block
  card: {
    backgroundColor: COLORS.white,
    padding: 18,
    borderRadius: 10,
    marginVertical: 12,
    shadowColor: COLORS.cardShadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.12,
    shadowRadius: 8,
    elevation: 4,
    borderWidth: 1.2,
    borderColor: COLORS.secondary,
  },
  // errorText: {
  //   color: COLORS.danger,
  //   marginBottom: 10,
  //   fontWeight: '500'
  // },
});

export default styles;
