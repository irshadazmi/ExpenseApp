import { StyleSheet } from "react-native";

const styles = StyleSheet.create({

  container: {
    flex: 1,
    justifyContent: "center",
    padding: 20
  },

  header: {
    fontSize: 30,
    fontWeight: "bold",
    color: "blue",
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
    alignItems: "center"
  },

  buttonText: {
    color: "#FFF"
  },

  error: {
    color: "red",
    textAlign: "center",
    marginTop: 10
  }

});

export default styles;