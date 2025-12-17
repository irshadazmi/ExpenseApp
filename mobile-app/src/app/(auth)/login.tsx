// mobile-app/src/app/(auth)/login.tsx

import React from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  ActivityIndicator,
  Image,
} from "react-native";
import { useRouter, Link, RelativePathString } from "expo-router";
import { Formik } from "formik";
import * as Yup from "yup";

import { useAuth } from "@/contexts/auth-context";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { budgetService } from "@/services/budget-service";

/* ======================================================
    VALIDATION
====================================================== */

const LoginSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),

  password: Yup.string().required("Password is required"),
});

/* ======================================================
    COMPONENT
====================================================== */

const Login = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const { user } = useAuth();

  const { login: authLogin, loading } = useAuth();

  const initialValues = {
    email: "",
    password: "",
  };

  /* ======================================================
      SUBMIT HANDLER
  ====================================================== */

  const handleSubmit = async (
    values: typeof initialValues,
    { setSubmitting, setStatus }: any
  ) => {
    try {
      const result = await authLogin(values);
      // console.log("User logged in:", result.user);
      const budgets = await budgetService.getByUser(result.user.id);
      
      if (budgets.length === 0) {
        budgetService.createAllBudgets(result.user.id);
      }
      else if (budgets[0].version === 0) {
        router.replace("/(budget)/edit-all" as RelativePathString);
      }
      else {
        router.replace("/(dashboard)");
      }
    } catch (error) {
      console.error(error);
      setStatus("Invalid credentials or network error.");
    } finally {
      setSubmitting(false);
    }
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <View style={styles.container}>

      {/* ---------- LOGO ---------- */}

      <Image
        source={require("@/assets/images/expense-logo.png")}
        resizeMode="contain"
        style={{
          width: 120,
          height: 120,
          alignSelf: "center",
          marginTop: -300,
          marginBottom: 16,
        }}
      />

      {/* ---------- TITLE ---------- */}

      <Text style={[styles.title, { marginBottom: 10 }]}>
        Login
      </Text>

      {/* ---------- FORM ---------- */}

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

            {/* ---------- API / AUTH ERROR ---------- */}

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
              placeholderTextColor={COLORS.textMuted}
              value={values.email}
              onChangeText={handleChange("email")}
              keyboardType="email-address"
              autoCapitalize="none"
            />

            {touched.email && errors.email && (
              <Text style={styles.errorText}>
                {errors.email}
              </Text>
            )}

            {/* ---------- PASSWORD ---------- */}

            <TextInput
              style={styles.textInput}
              placeholder="Password"
              placeholderTextColor={COLORS.textMuted}
              value={values.password}
              onChangeText={handleChange("password")}
              secureTextEntry
            />

            {touched.password && errors.password && (
              <Text style={styles.errorText}>
                {errors.password}
              </Text>
            )}

            {/* ---------- FORGOT PASSWORD ---------- */}

            <Pressable
              onPress={() =>
                router.push("/(auth)/forgot-password")
              }
              style={{
                alignSelf: "flex-end",
                marginTop: 4,
                marginBottom: 12,
              }}
            >
              <Text
                style={{
                  fontSize: 13,
                  color: COLORS.primary,
                  textDecorationLine: "underline",
                }}
              >
                Forgot password?
              </Text>
            </Pressable>

            {/* ---------- SUBMIT ---------- */}

            {loading || isSubmitting ? (
              <ActivityIndicator
                size="small"
                color={COLORS.primary}
              />
            ) : (
              <Pressable
                style={styles.button}
                onPress={() => handleSubmit()}
                disabled={loading || isSubmitting}
              >
                <Text style={styles.buttonText}>
                  Login
                </Text>
              </Pressable>
            )}

            {/* ---------- REGISTER LINK ---------- */}

            <Link href="./register" style={styles.link}>
              <Text>
                Not registered? Create an account
              </Text>
            </Link>
          </View>
        )}
      </Formik>
    </View>
  );
};

export default Login;
