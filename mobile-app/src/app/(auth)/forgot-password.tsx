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
import { Formik } from "formik";
import * as Yup from "yup";
import Constants from "expo-constants";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

/* ======================================================
    CONFIG
====================================================== */

const API_BASE_URL = Constants.expoConfig?.extra?.API_BASE_URL;

/* ======================================================
    VALIDATION
====================================================== */

const ForgotPasswordSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),
});

/* ======================================================
    COMPONENT
====================================================== */

const ForgotPassword = () => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ unified theme colors

  const router = useRouter();
  const [submittingFlag, setSubmittingFlag] = useState(false);

  const initialValues = {
    email: "",
  };

  /* ======================================================
      SUBMIT HANDLER
====================================================== */

  const handleSubmit = async (
    values: typeof initialValues,
    { setSubmitting, setStatus }: any
  ) => {
    setStatus(null);
    setSubmittingFlag(true);

    try {
      const res = await fetch(
        `${API_BASE_URL}/auth/forgot-password`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            email: values.email,
          }),
        }
      );

      if (!res.ok) {
        const errorText = await res.text().catch(() => "");
        console.warn("Forgot password error:", errorText);
        throw new Error("Request failed");
      }

      Alert.alert(
        "Email sent",
        "If this email is registered, you will receive password reset instructions shortly."
      );

      router.back();
    } catch (err) {
      console.error(err);
      setStatus(
        "Unable to process request. Please try again."
      );
    } finally {
      setSubmitting(false);
      setSubmittingFlag(false);
    }
  };

  /* ======================================================
      UI
====================================================== */

  return (
    <View style={styles.container}>
      {/* ---------- TITLE ---------- */}
      <Text style={styles.title}>
        Forgot Password
      </Text>

      <Text
        style={[
          styles.text,
          {
            textAlign: "center",
            marginBottom: 16,
            color: COLORS.text,
          },
        ]}
      >
        Enter your registered email address and we’ll send
        you instructions to reset your password.
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
            {/* ---------- STATUS ---------- */}
            {status && (
              <Text
                style={[
                  styles.errorText,
                  { marginBottom: 8 },
                ]}
              >
                {status}
              </Text>
            )}

            {/* ---------- EMAIL ---------- */}
            <TextInput
              style={styles.textInput}
              placeholder="Email"
              placeholderTextColor={
                COLORS.textMuted
              }
              value={values.email}
              onChangeText={handleChange(
                "email"
              )}
              keyboardType="email-address"
              autoCapitalize="none"
            />

            {touched.email && errors.email && (
              <Text style={styles.errorText}>
                {errors.email}
              </Text>
            )}

            {/* ---------- SUBMIT ---------- */}
            {isSubmitting || submittingFlag ? (
              <ActivityIndicator
                size="small"
                color={COLORS.primary}
              />
            ) : (
              <Pressable
                style={styles.button}
                onPress={() => handleSubmit()}
                disabled={
                  isSubmitting || submittingFlag
                }
              >
                <Text style={styles.buttonText}>
                  Send reset link
                </Text>
              </Pressable>
            )}

            {/* ---------- BACK ---------- */}
            <Pressable
              onPress={() => router.back()}
              style={{
                marginTop: 12,
                alignSelf: "center",
              }}
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
