// src/app/(auth)/login.tsx
import React from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  KeyboardAvoidingView,
  Platform,
  Image,
  ActivityIndicator,
} from "react-native";
import { useRouter } from "expo-router";
import { Formik } from "formik";
import * as Yup from "yup";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { useAuth } from "@/contexts/auth-context";

/* ======================================================
   VALIDATION
====================================================== */

const LoginSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),
  password: Yup.string()
    .min(6, "Minimum 6 characters")
    .required("Password is required"),
});

/* ======================================================
   COMPONENT
====================================================== */

export default function LoginScreen() {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const { loginWithCredentials } = useAuth();

  const [submitting, setSubmitting] = React.useState(false);
  const [formError, setFormError] = React.useState<string | null>(null);

  const handleSubmit = async (values: {
    email: string;
    password: string;
  }) => {
    if (submitting) return;
    setSubmitting(true);
    setFormError(null);

    try {
      await loginWithCredentials(
        values.email.trim(),
        values.password
      );
      router.replace("/(dashboard)");
    } catch (err: any) {
      setFormError(
        err?.response?.data?.detail ??
        "Invalid email or password"
      );
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <KeyboardAvoidingView
      style={{ flex: 1, backgroundColor: COLORS.background }}
      behavior={Platform.OS === "ios" ? "padding" : undefined}
    >
      <View
        style={styles.container}
      >
        {/* ---------- BRAND ---------- */}
        <View style={{ alignItems: "center" }}>
          <Image
            source={require("@/assets/images/expense-logo.png")}
            style={{ width: '100%', height: 150 }}
            resizeMode="contain"
          />

          <Text style={styles.title}>
            Welcome to Dantify
          </Text>

          <Text style={styles.mutedText}>
            AI-powered dental practice management
          </Text>
        </View>

        {/* ---------- FORM CARD ---------- */}
        <View
          style={styles.card}
        >
          <Formik
            initialValues={{ email: "", password: "" }}
            validationSchema={LoginSchema}
            onSubmit={handleSubmit}
          >
            {({
              values,
              errors,
              touched,
              handleChange,
              handleSubmit,
            }) => (
              <>
                {/* Email */}
                <Text style={styles.label}>Email</Text>
                <TextInput
                  style={styles.textInput}
                  placeholder="dentist@example.com"
                  placeholderTextColor={COLORS.textMuted}
                  autoCapitalize="none"
                  keyboardType="email-address"
                  value={values.email}
                  onChangeText={handleChange("email")}
                />
                {touched.email && errors.email && (
                  <Text style={styles.errorText}>
                    {errors.email}
                  </Text>
                )}

                {/* Password */}
                <Text style={styles.label}>Password</Text>
                <TextInput
                  style={styles.textInput}
                  placeholder="Enter your password"
                  placeholderTextColor={COLORS.textMuted}
                  secureTextEntry
                  value={values.password}
                  onChangeText={handleChange("password")}
                />
                {touched.password && errors.password && (
                  <Text style={styles.errorText}>
                    {errors.password}
                  </Text>
                )}

                {/* Error */}
                {formError && (
                  <Text
                    style={[
                      styles.errorText,
                      { textAlign: "center", marginTop: 4 },
                    ]}
                  >
                    {formError}
                  </Text>
                )}

                {/* Forgot */}
                <Pressable
                  onPress={() =>
                    router.push("/(auth)/forgot-password")
                  }
                  style={{ alignSelf: "flex-end", marginTop: 6 }}
                >
                  <Text
                    style={{
                      fontSize: 13,
                      color: COLORS.primary,
                      fontWeight: "500",
                    }}
                  >
                    Forgot password?
                  </Text>
                </Pressable>

                {/* Submit */}
                <Pressable
                  onPress={() => handleSubmit()}
                  disabled={submitting}
                  style={[
                    styles.button,
                    { marginTop: 16, opacity: submitting ? 0.7 : 1 },
                  ]}
                >
                  {submitting ? (
                    <ActivityIndicator
                      color={COLORS.badgeText}
                    />
                  ) : (
                    <Text style={styles.buttonText}>
                      Sign in
                    </Text>
                  )}
                </Pressable>
              </>
            )}
          </Formik>
        </View>

        {/* ---------- REGISTER ---------- */}
        <View
          style={{
            flexDirection: "row",
            justifyContent: "center",
            alignItems: "center",
          }}
        >
          <Text style={styles.mutedText}>
            Not registered?{" "}
          </Text>

          <Pressable onPress={() => router.push("/(auth)/register")}>
            <Text
              style={{
                fontSize: 14,
                fontWeight: "600",
                color: COLORS.primary,
              }}
            >
              Create an account
            </Text>
          </Pressable>
        </View>
      </View>
    </KeyboardAvoidingView>
  );
}
