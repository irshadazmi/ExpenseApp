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
import styles from "@/styles/styles";
import { AuthRegisterSchema } from "@/types/auth";
import { Link, useRouter } from "expo-router";
import { Formik } from "formik";
import * as Yup from "yup";
import { COLORS } from "@/constants/COLORS";

const RegisterSchema = Yup.object().shape({
  email: Yup.string()
    .email("Please enter a valid email")
    .required("Email is required"),
  password: Yup.string()
    .min(6, "Password should be at least 6 characters")
    .required("Password is required"),
  confirm_password: Yup.string()
    .oneOf([Yup.ref("password")], "Passwords must match")
    .required("Confirm password is required"),
  phone: Yup.string().required("Phone is required"),
});

const Register = () => {
  const { register: doRegister, login, loading } = useAuth();
  const router = useRouter();

  const initialValues: AuthRegisterSchema = {
    email: "",
    password: "",
    confirm_password: "",
    phone: "",
    role_id: 3,      // or default role if backend uses one
    is_active: true, // or false based on your backend logic
  };

  const handleSubmit = async (
    values: AuthRegisterSchema,
    { setSubmitting, setStatus }: any
  ) => {
    setStatus(null);
    try {
      await doRegister({ userData: values });
      // auto login
      await login({ email: values.email, password: values.password });
      router.replace("/(drawer)/(tabs)");
    } catch (error) {
      console.error(error);
      setStatus("Registration failed. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <View style={styles.container}>
      <Image
        source={require("@/assets/images/expense-logo.png")}
        style={{
          width: "30%",
          height: "20%",
          alignSelf: "center",
          marginBottom: 0,
        }}
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
            {/* Global / API error */}
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

            {/* Confirm Password */}
            <TextInput
              style={styles.textInput}
              placeholder="Confirm Password"
              value={values.confirm_password}
              onChangeText={handleChange("confirm_password")}
              secureTextEntry
            />
            {touched.confirm_password && errors.confirm_password && (
              <Text style={styles.errorText}>{errors.confirm_password}</Text>
            )}

            {/* Phone */}
            <TextInput
              style={styles.textInput}
              placeholder="Phone"
              value={values.phone}
              onChangeText={handleChange("phone")}
              keyboardType="phone-pad"
            />
            {touched.phone && errors.phone && (
              <Text style={styles.errorText}>{errors.phone}</Text>
            )}

            {/* Submit button */}
            {loading || isSubmitting ? (
              <ActivityIndicator size="small" color={COLORS.primary} />
            ) : (
              <Pressable
                style={styles.button}
                onPress={() => handleSubmit()}
                disabled={loading || isSubmitting}
              >
                <Text style={styles.buttonText}>Register</Text>
              </Pressable>
            )}

            <Link href="./login" style={styles.link}>
              <Text>Already have an account? Login</Text>
            </Link>
          </View>
        )}
      </Formik>
    </View>
  );
};

export default Register;
