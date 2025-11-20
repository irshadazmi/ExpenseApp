// src/app/(auth)/forgot-password.tsx
import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  ActivityIndicator,
  Alert,
} from "react-native";
import { useRouter } from "expo-router";
import styles from "@/styles/styles";
import * as Yup from "yup";
import { Formik } from "formik";
import Constants from "expo-constants";
import { COLORS } from "@/constants/COLORS";

const API_BASE_URL = Constants.expoConfig?.extra?.API_BASE_URL;

const ForgotPasswordSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),
});

const ForgotPassword = () => {
  const router = useRouter();
  const [submitting, setSubmittingFlag] = useState(false);

  const initialValues = {
    email: "",
  };

  const handleSubmit = async (
    values: typeof initialValues,
    { setSubmitting, setStatus }: any
  ) => {
    setStatus(null);
    setSubmittingFlag(true);
    try {
      const res = await fetch(`${API_BASE_URL}/auth/forgot-password`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: values.email }),
      });

      if (!res.ok) {
        const errorText = await res.text().catch(() => "");
        console.warn("Forgot password error:", errorText);
        throw new Error("Request failed");
      }

      Alert.alert(
        "Email sent",
        "If this email is registered, you will receive password reset instructions shortly."
      );
      router.back(); // take user back to login
    } catch (error) {
      console.error(error);
      setStatus("Unable to process request. Please try again.");
    } finally {
      setSubmitting(false);
      setSubmittingFlag(false);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Forgot Password</Text>
      <Text style={[styles.text, { textAlign: "center", marginBottom: 16 }]}>
        Enter your registered email address and we’ll send you instructions to reset your password.
      </Text>

      <Formik
        initialValues={initialValues}
        validationSchema={ForgotPasswordSchema}
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
            {/* Global status message */}
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

            {/* Submit button / loader */}
            {isSubmitting || submitting ? (
              <ActivityIndicator size="small" color={COLORS.primary} />
            ) : (
              <Pressable
                style={styles.button}
                onPress={() => handleSubmit()}
                disabled={isSubmitting || submitting}
              >
                <Text style={styles.buttonText}>Send reset link</Text>
              </Pressable>
            )}

            {/* Back to login */}
            <Pressable
              onPress={() => router.back()}
              style={{ marginTop: 12, alignSelf: "center" }}
            >
              <Text
                style={{
                  fontSize: 14,
                  color: COLORS.primary,
                  textDecorationLine: "underline",
                }}
              >
                Back to Login
              </Text>
            </Pressable>
          </View>
        )}
      </Formik>
    </View>
  );
};

export default ForgotPassword;
