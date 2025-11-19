// src/app/(auth)/login.tsx
import React from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  ActivityIndicator,
  Image,
} from "react-native";
import { useAuth } from "@/contexts/auth-context";
import { Link, useRouter } from "expo-router";
import styles from "@/styles/styles";
import { Formik } from "formik";
import * as Yup from "yup";
import { COLORS } from "@/constants/COLORS";

const LoginSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),
  password: Yup.string().required("Password is required"),
});

const Login = () => {
  const router = useRouter();
  const { login: authLogin, loading } = useAuth();

  const initialValues = {
    email: "",
    password: "",
  };

  const handleSubmit = async (
    values: typeof initialValues,
    { setSubmitting, setStatus }: any
  ) => {
    setStatus(null);
    try {
      await authLogin({ email: values.email, password: values.password });
      router.replace("/dashboard");
    } catch (error) {
      console.error(error);
      setStatus("Invalid credentials or network error.");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <View style={styles.container}>
      <Image
        source={require("@/assets/images/expense-logo.png")}
        style={{
          width: "40%",
          height: "25%",
          alignSelf: "center",
          marginTop: -200,
          marginBottom: 0,
        }}
      />

      <Text style={styles.title}>Login</Text>

      <Formik
        initialValues={initialValues}
        validationSchema={LoginSchema}
        onSubmit={handleSubmit}
      >
        {({
          values,
          errors,
          touched,
          handleChange,
          handleSubmit,
          isSubmitting,
          status,
        }) => (
          <View style={{ width: "100%" }}>
            {/* Global error (API / auth) */}
            {status && (
              <Text style={[styles.errorText, { marginBottom: 8 }]}>{status}</Text>
            )}

            {/* Email */}
            <TextInput
              style={styles.textInput}
              placeholder="Email"
              value={values.email}
              onChangeText={handleChange("email")}
              keyboardType="email-address"
              autoCapitalize="none"
            />
            {touched.email && errors.email && (
              <Text style={styles.errorText}>{errors.email}</Text>
            )}

            {/* Password */}
            <TextInput
              style={styles.textInput}
              placeholder="Password"
              value={values.password}
              onChangeText={handleChange("password")}
              secureTextEntry
            />
            {touched.password && errors.password && (
              <Text style={styles.errorText}>{errors.password}</Text>
            )}

            {/* Button / loader */}
            {loading || isSubmitting ? (
              <ActivityIndicator size="small" color={COLORS.primary} />
            ) : (
              <Pressable
                style={styles.button}
                onPress={() => handleSubmit()}
                disabled={loading || isSubmitting}
              >
                <Text style={styles.buttonText}>Login</Text>
              </Pressable>
            )}

            <Link href="./register" style={styles.link}>
              <Text>Not registered? Create an account</Text>
            </Link>
          </View>
        )}
      </Formik>
    </View>
  );
};

export default Login;
