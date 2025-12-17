// src/app/(auth)/register.tsx

import React from "react";
import {
  View,
  Text,
  TextInput,
  Image,
  ActivityIndicator,
  Pressable,
} from "react-native";

import { useAuth } from "@/contexts/auth-context";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { AuthRegisterSchema } from "@/types/auth";
import { Link, useRouter } from "expo-router";

import { Formik } from "formik";
import * as Yup from "yup";

/* ======================================================
    VALIDATION
====================================================== */

const RegisterSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),

  full_name: Yup.string()
    .trim()
    .required("Full name is required"),

  password: Yup.string()
    .min(6, "Password should be at least 6 characters")
    .required("Password is required"),

  confirm_password: Yup.string()
    .oneOf([Yup.ref("password")], "Passwords must match")
    .required("Confirm password is required"),

  phone: Yup.string().required("Phone is required"),
});

/* ======================================================
    COMPONENT
====================================================== */

const Register = () => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const { register: doRegister, login, loading } = useAuth();
  const router = useRouter();

  const initialValues: AuthRegisterSchema = {
    full_name: "",
    email: "",
    password: "",
    confirm_password: "",
    phone: "",
    role_id: 3,
    is_active: true,
  };

  /* ======================================================
      SUBMIT HANDLER
  ====================================================== */

  const handleSubmit = async (
    values: AuthRegisterSchema,
    { setSubmitting, setStatus }: any
  ) => {
    setStatus(null);

    try {
      await doRegister({ userData: values });

      // ✅ Auto login after registration
      await login({
        email: values.email,
        password: values.password,
      });

      router.replace("/(drawer)/(tabs)");
    } catch (error) {
      console.error(error);
      setStatus("Registration failed. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <View style={styles.container}>
      {/* Logo */}
      <Image
        source={require("@/assets/images/expense-logo.png")}
        style={{
          width: "40%",
          height: "20%",
          alignSelf: "center",
          marginTop: -100,
          marginBottom: 0,
        }}
        resizeMode="contain"
      />

      <Text style={styles.title}>Register</Text>

      <Formik
        initialValues={initialValues}
        validationSchema={RegisterSchema}
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
            {/* GLOBAL ERROR */}
            {status && (
              <Text
                style={[styles.errorText, { marginBottom: 8 }]}
              >
                {status}
              </Text>
            )}

            {/* EMAIL */}
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

            {/* FULL NAME */}
            <TextInput
              style={styles.textInput}
              placeholder="Full Name"
              placeholderTextColor={COLORS.textMuted}
              value={values.full_name}
              onChangeText={handleChange("full_name")}
            />
            {touched.full_name && errors.full_name && (
              <Text style={styles.errorText}>
                {errors.full_name}
              </Text>
            )}

            {/* PASSWORD */}
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

            {/* CONFIRM PASSWORD */}
            <TextInput
              style={styles.textInput}
              placeholder="Confirm Password"
              placeholderTextColor={COLORS.textMuted}
              value={values.confirm_password}
              onChangeText={handleChange("confirm_password")}
              secureTextEntry
            />
            {touched.confirm_password &&
              errors.confirm_password && (
                <Text style={styles.errorText}>
                  {errors.confirm_password}
                </Text>
              )}

            {/* PHONE */}
            <TextInput
              style={styles.textInput}
              placeholder="Phone"
              placeholderTextColor={COLORS.textMuted}
              value={values.phone}
              onChangeText={handleChange("phone")}
              keyboardType="phone-pad"
            />
            {touched.phone && errors.phone && (
              <Text style={styles.errorText}>
                {errors.phone}
              </Text>
            )}

            {/* SUBMIT */}
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
                  Register
                </Text>
              </Pressable>
            )}

            {/* LOGIN LINK */}
            <Link href="./login" style={styles.link}>
              <Text>
                Already have an account? Login
              </Text>
            </Link>
          </View>
        )}
      </Formik>
    </View>
  );
};

export default Register;
