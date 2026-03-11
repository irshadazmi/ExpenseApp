import { View, Text, TextInput, Pressable, KeyboardAvoidingView, Image } from "react-native";
import { useState } from "react";
import { useRouter } from "expo-router";
import styles from "../../styles/styles";

export default function Login() {

  const router = useRouter();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleLogin = () => {

    if (email === "abc@xyz.com" && password === "1234") {
      router.push("/(dashboard)");
    } else {
      setError("Invalid email or password");
    }

  };

  return (
    <KeyboardAvoidingView style={{ flex: 1 }} behavior="padding">
      <View style={styles.container}>
        <Image
            source={require("../../assets/images/expense-logo.png")}
            style={{ width: '100%', height: 150 }}
            resizeMode="contain"
          />

        <Text style={styles.title}>
          ExpenseApp Login
        </Text>

        <TextInput
          style={styles.input}
          placeholder="Email"
          value={email}
          onChangeText={setEmail}
        />

        <TextInput
          style={styles.input}
          placeholder="Password"
          secureTextEntry
          value={password}
          onChangeText={setPassword}
        />

        <Pressable style={styles.button} onPress={handleLogin}>
          <Text style={styles.buttonText}>Login</Text>
        </Pressable>

        {error !== "" && (
          <Text style={styles.error}>
            {error}
          </Text>
        )}

      </View>
    </KeyboardAvoidingView>
  );
}