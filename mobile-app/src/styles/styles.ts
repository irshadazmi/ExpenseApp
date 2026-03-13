import { Platform, StatusBar, StyleSheet } from "react-native";

const styles = StyleSheet.create({

  container: {
      flex: 1,
      padding: 10,
      marginTop: 20,
      textAlign: "left"
    },

  header: {
    height: 60,
    backgroundColor: '#6200ee',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 16,

    elevation: 4, // Android shadow
    shadowColor: '#000', // iOS shadow
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
  },

  headerTitle: {
    color: 'white',
    fontSize: 20,
    fontWeight: 'bold'
  },

  content: {
    flex: 1,
  },

  title: {
    fontSize: 24,
    textAlign: "center",
    marginBottom: 20
  },

  welcome: {
    fontSize: 18,
    textAlign: "center",
    marginBottom: 20
  },

  input: {
    borderWidth: 1,
    padding: 10,
    marginBottom: 10
  },

  button: {
    backgroundColor: "#2F80ED",
    padding: 12,
    alignItems: "center",
    marginBottom: 10
  },

  buttonText: {
    color: "#FFF"
  },

  error: {
    color: "red",
    textAlign: "center",
    marginTop: 10
  },

  card: {
    backgroundColor: "#fff",
    padding: 16,
    borderRadius: 8,
    marginBottom: 12,
    elevation: 2
  },

  cardTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 6
  },

  cardText: {
    fontSize: 14,
    marginBottom: 2
  }
});

export default styles;