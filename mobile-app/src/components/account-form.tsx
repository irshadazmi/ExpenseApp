// src/components/account-form.tsx

import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  ScrollView,
  Alert,
  ActivityIndicator,
} from "react-native";

import { Formik } from "formik";
import * as Yup from "yup";
import { useRouter } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { accountService } from "@/services/account-service";
import {
  ACCOUNT_TYPES,
  CURRENCIES,
} from "@/constants/CONSTANTS";

/* ======================================================
    TYPES
====================================================== */

export interface AccountCreate {
  name: string;
  type: string;
  balance: number;
  currency: string;
  is_active: boolean;
}

interface AccountFormProps {
  id?: number;
  onSubmitSuccess?: () => void;
}

/* ======================================================
    VALIDATION
====================================================== */

const AccountSchema = Yup.object().shape({
  name: Yup.string().trim().required("Account name is required"),
  type: Yup.string()
    .oneOf(ACCOUNT_TYPES)
    .required("Account type is required"),
  balance: Yup.number()
    .typeError("Balance must be a number")
    .required("Balance is required"),
  currency: Yup.string()
    .oneOf(CURRENCIES)
    .required("Currency is required"),
  is_active: Yup.boolean(),
});

/* ======================================================
    MAIN COMPONENT
====================================================== */

const AccountForm: React.FC<AccountFormProps> = ({
  id,
  onSubmitSuccess,
}) => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ central theme colors
  const router = useRouter();

  const [loading, setLoading] = useState(false);
  const isEditing = typeof id === "number";

  const [initialValues, setInitialValues] =
    useState<AccountCreate>({
      name: "",
      type: "Checking",
      balance: 0,
      currency: "INR",
      is_active: true,
    });

  /* ======================================================
      LOAD EXISTING ACCOUNT
====================================================== */

  useEffect(() => {
    if (!isEditing) return;

    setLoading(true);

    accountService
      .getById(id!)
      .then((account) => {
        if (!account) return;

        setInitialValues({
          name: account.name ?? "",
          type: account.type ?? "Checking",
          balance: Number(account.balance ?? 0),
          currency: account.currency ?? "INR",
          is_active: account.is_active ?? true,
        });
      })
      .catch(() => {
        Alert.alert("Error", "Failed to load account data.");
      })
      .finally(() => setLoading(false));
  }, [id, isEditing]);

  /* ======================================================
      SUBMIT HANDLER
====================================================== */

  const handleSubmit = async (
    values: AccountCreate,
    { resetForm, setSubmitting }: any
  ) => {
    try {
      setSubmitting(true);

      if (isEditing) {
        await accountService.update(id!, values);
        Alert.alert("Success", "Account updated successfully.");
      } else {
        await accountService.create(values);
        Alert.alert("Success", "Account added successfully.");
        resetForm();
      }

      onSubmitSuccess?.();
      router.back();
    } catch {
      Alert.alert("Error", "Failed to save account.");
    } finally {
      setSubmitting(false);
    }
  };

  /* ======================================================
      LOADING STATE
====================================================== */

  if (loading && isEditing) {
    return (
      <View
        style={[
          styles.container,
          {
            justifyContent: "center",
            alignItems: "center",
          },
        ]}
      >
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={{ marginTop: 12, color: COLORS.text }}>
          Loading account data...
        </Text>
      </View>
    );
  }

  /* ======================================================
      UI
====================================================== */

  return (
    <ScrollView showsVerticalScrollIndicator={true}> 
      <Formik
        initialValues={initialValues}
        enableReinitialize
        validationSchema={AccountSchema}
        onSubmit={handleSubmit}
      >
        {({
          values,
          errors,
          touched,
          handleChange,
          handleSubmit,
          isSubmitting,
          isValid,
          setFieldValue,
        }) => (
          <View style={styles.formContainer}>
            <Text style={styles.label}>Account Name</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter account name"
              placeholderTextColor={COLORS.textMuted}
              value={values.name}
              onChangeText={handleChange("name")}
              editable={!isSubmitting}
            />

            {touched.name && errors.name && (
              <Text style={styles.errorText}>
                {errors.name}
              </Text>
            )}

            <Text style={styles.label}>Account Type</Text>

            <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
              {ACCOUNT_TYPES.map((type) => {
                const active = values.type === type;

                return (
                  <Pressable
                    key={type}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue("type", type)
                    }
                    disabled={isSubmitting}
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active && styles.chipTextSelected,
                      ]}
                    >
                      {type}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.type && errors.type && (
              <Text style={styles.errorText}>
                {errors.type}
              </Text>
            )}

            <Text style={styles.label}>Balance</Text>

            <TextInput
              style={styles.textInput}
              placeholder="Enter balance"
              placeholderTextColor={COLORS.textMuted}
              value={String(values.balance ?? "")}
              onChangeText={(v) =>
                setFieldValue("balance", Number(v))
              }
              keyboardType="numeric"
              editable={!isSubmitting}
            />

            {touched.balance && errors.balance && (
              <Text style={styles.errorText}>
                {errors.balance}
              </Text>
            )}

            <Text style={styles.label}>Currency</Text>

            <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
              {CURRENCIES.map((cur) => {
                const active = values.currency === cur;

                return (
                  <Pressable
                    key={cur}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue("currency", cur)
                    }
                    disabled={isSubmitting}
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active && styles.chipTextSelected,
                      ]}
                    >
                      {cur}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.currency && errors.currency && (
              <Text style={styles.errorText}>
                {errors.currency}
              </Text>
            )}

            <View
              style={{
                flexDirection: "row",
                alignItems: "center",
                marginVertical: 12,
              }}
            >
              <Text style={{ fontSize: 16, color: COLORS.text }}>
                Active
              </Text>

              <Pressable
                onPress={() =>
                  setFieldValue(
                    "is_active",
                    !values.is_active
                  )
                }
                style={{ marginLeft: 10 }}
                disabled={isSubmitting}
              >
                <View
                  style={{
                    width: 24,
                    height: 24,
                    borderRadius: 12,
                    borderWidth: 2,
                    borderColor: COLORS.primary,
                    backgroundColor: values.is_active
                      ? COLORS.primary
                      : "transparent",
                  }}
                />
              </Pressable>
            </View>

            <Pressable
              style={[
                styles.button,
                (!isValid || isSubmitting) && {
                  opacity: 0.6,
                },
              ]}
              disabled={!isValid || isSubmitting}
              onPress={() => handleSubmit()}
            >
              <Text style={styles.buttonText}>
                {isSubmitting
                  ? "Saving..."
                  : isEditing
                    ? "Update Account"
                    : "Save Account"}
              </Text>
            </Pressable>

          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default AccountForm;
