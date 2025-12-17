// src/components/transaction-form.tsx

import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  Platform,
  ScrollView,
  ActivityIndicator,
  Alert,
} from "react-native";

import DateTimePicker from "@react-native-community/datetimepicker";
import { Formik } from "formik";
import * as Yup from "yup";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { TransactionCreate } from "@/types/transaction";
import { categoryService } from "@/services/category-service";
import { transactionService } from "@/services/transaction-service";
import { useAuth } from "@/contexts/auth-context";

import { CURRENCIES, EXPENSE_TYPES } from "@/constants/CONSTANTS";

/* ======================================================
   VALIDATION
====================================================== */

const TransactionSchema = Yup.object().shape({
  description: Yup.string().trim().required("Description is required"),

  amount: Yup.number()
    .typeError("Amount must be a number")
    .positive("Amount must be greater than zero")
    .required("Amount is required"),

  category_id: Yup.number()
    .moreThan(0, "Category is required")
    .required("Category is required"),

  transaction_date: Yup.date().required(
    "Transaction date is required"
  ),

  type: Yup.string()
    .oneOf(EXPENSE_TYPES)
    .required("Type is required"),

  currency: Yup.string()
    .oneOf(CURRENCIES)
    .required("Currency is required"),
});

/* ======================================================
   TYPES
====================================================== */

interface TransactionFormProps {
  id?: number;
  onSubmitSuccess?: () => void;
}

/* ======================================================
   COMPONENT
====================================================== */

const TransactionForm: React.FC<
  TransactionFormProps
> = ({ id, onSubmitSuccess }) => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const { user } = useAuth();

  const [categories, setCategories] =
    useState<{ id: number; name: string }[]>([]);

  const [showDatePicker, setShowDatePicker] =
    useState(false);

  const [loading, setLoading] = useState(false);

  const [
    initialValues,
    setInitialValues,
  ] = useState<TransactionCreate | null>(null);

  const isEditing = typeof id === "number";

  /* ======================================================
      LOAD CATEGORIES
  ====================================================== */

  useEffect(() => {
    (async () => {
      try {
        const res = await categoryService.getAll();

        const safeCategories = res
          .filter((c) => typeof c.id === "number")
          .map((c) => ({
            id: c.id as number,
            name: c.name,
          }));

        setCategories(safeCategories);
      } catch {
        Alert.alert(
          "Error",
          "Failed to load categories"
        );
      }
    })();
  }, []);

  /* ======================================================
      LOAD TRANSACTION
  ====================================================== */

  useEffect(() => {
    if (!user) return;

    if (isEditing) {
      setLoading(true);

      transactionService
        .getById(id!)
        .then((tx) => {
          if (!tx) return;

          setInitialValues({
            description: tx.description ?? "",
            amount: Number(tx.amount) ?? 0,
            category_id: Number(tx.category_id) ?? 0,
            type: tx.type ?? "Expense",
            currency: tx.currency ?? "INR",
            transaction_date:
              tx.transaction_date ??
              new Date().toISOString(),
            user_id: user.id,
          });
        })
        .catch(() =>
          Alert.alert(
            "Error",
            "Failed to load transaction"
          )
        )
        .finally(() => setLoading(false));
    } else {
      setInitialValues({
        description: "",
        amount: 0,
        category_id: 0,
        type: "Expense",
        currency: "INR",
        transaction_date:
          new Date().toISOString(),
        user_id: user.id,
      });
    }
  }, [id, isEditing, user]);

  /* ======================================================
      USER SAFETY
  ====================================================== */

  if (!user) {
    return (
      <Text style={styles.errorText}>
        Please login again. User is missing.
      </Text>
    );
  }

  if (!initialValues || loading) {
    return (
      <View
        style={[
          styles.container,
          {
            alignItems: "center",
            justifyContent: "center",
          },
        ]}
      >
        <ActivityIndicator
          size="large"
          color={COLORS.primary}
        />

        <Text style={{ marginTop: 12, color: COLORS.text }}>
          Loading transaction...
        </Text>
      </View>
    );
  }

  /* ======================================================
      SUBMIT
  ====================================================== */

  const handleSubmit = async (
    values: TransactionCreate,
    { resetForm, setSubmitting }: any
  ) => {
    try {
      if (isEditing) {
        await transactionService.update(id!, values);
        Alert.alert("Success", "Transaction updated");
      } else {
        await transactionService.create(values);
        Alert.alert("Success", "Transaction created");
        resetForm();
      }

      onSubmitSuccess?.();
    } catch {
      Alert.alert(
        "Error",
        "Failed to save transaction"
      );
    } finally {
      setSubmitting(false);
    }
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <ScrollView
      keyboardShouldPersistTaps="handled"
      showsVerticalScrollIndicator
    >
      <Formik
        initialValues={initialValues}
        enableReinitialize
        validationSchema={TransactionSchema}
        onSubmit={handleSubmit}
      >
        {({
          values,
          errors,
          touched,
          handleChange,
          setFieldValue,
          handleSubmit,
          isSubmitting,
          isValid,
        }) => (
          <View style={styles.formContainer}>

            {/* ================= CATEGORY ================= */}

            <Text style={styles.label}>Category</Text>

            <View
              style={[
                styles.chipsContainer,
                { flexWrap: "wrap" },
              ]}
            >
              {categories.map((cat) => {
                const active =
                  values.category_id === cat.id;

                return (
                  <Pressable
                    key={cat.id}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue(
                        "category_id",
                        cat.id
                      )
                    }
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active &&
                          styles.chipTextSelected,
                      ]}
                    >
                      {cat.name}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.category_id &&
              errors.category_id && (
                <Text style={styles.errorText}>
                  {errors.category_id}
                </Text>
              )}

            {/* ================= TYPE ================= */}

            <Text style={styles.label}>Type</Text>

            <View
              style={[
                styles.chipsContainer,
                { flexWrap: "wrap" },
              ]}
            >
              {EXPENSE_TYPES.map((t) => {
                const active = values.type === t;

                return (
                  <Pressable
                    key={t}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue("type", t)
                    }
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active &&
                          styles.chipTextSelected,
                      ]}
                    >
                      {t}
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

            {/* ================= CURRENCY ================= */}

            <Text style={styles.label}>Currency</Text>

            <View
              style={[
                styles.chipsContainer,
                { flexWrap: "wrap" },
              ]}
            >
              {CURRENCIES.map((cur) => {
                const active =
                  values.currency === cur;

                return (
                  <Pressable
                    key={cur}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue(
                        "currency",
                        cur
                      )
                    }
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active &&
                          styles.chipTextSelected,
                      ]}
                    >
                      {cur}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.currency &&
              errors.currency && (
                <Text style={styles.errorText}>
                  {errors.currency}
                </Text>
              )}

            {/* ================= DESCRIPTION ================= */}

            <Text style={styles.label}>Description</Text>

            <TextInput
              style={styles.textInput}
              placeholder="Enter description"
              placeholderTextColor={COLORS.textMuted}
              value={values.description}
              onChangeText={handleChange("description")}
            />

            {touched.description &&
              errors.description && (
                <Text style={styles.errorText}>
                  {errors.description}
                </Text>
              )}

            {/* ================= AMOUNT ================= */}

            <Text style={styles.label}>Amount</Text>

            <TextInput
              style={styles.textInput}
              placeholder="Enter amount"
              placeholderTextColor={COLORS.textMuted}
              keyboardType="numeric"
              value={String(values.amount ?? "")}
              onChangeText={(v) =>
                setFieldValue(
                  "amount",
                  Number(v)
                )
              }
            />

            {touched.amount &&
              errors.amount && (
                <Text style={styles.errorText}>
                  {errors.amount}
                </Text>
              )}

            {/* ================= DATE ================= */}

            <Text style={styles.label}>
              Transaction Date
            </Text>

            <Pressable
              style={[
                styles.textInput,
                styles.dateInput,
              ]}
              onPress={() =>
                setShowDatePicker(true)
              }
            >
              <Text style={styles.dateText}>
                {values.transaction_date
                  ? new Date(
                      values.transaction_date
                    ).toLocaleDateString()
                  : "Select Date"}
              </Text>
            </Pressable>

            {showDatePicker && (
              <DateTimePicker
                value={new Date(
                  values.transaction_date
                )}
                mode="date"
                display={
                  Platform.OS === "ios"
                    ? "spinner"
                    : "default"
                }
                onChange={(_, selectedDate) => {
                  setShowDatePicker(false);

                  if (selectedDate) {
                    setFieldValue(
                      "transaction_date",
                      selectedDate.toISOString()
                    );
                  }
                }}
              />
            )}

            {touched.transaction_date &&
              errors.transaction_date && (
                <Text style={styles.errorText}>
                  {errors.transaction_date as string}
                </Text>
              )}

            {/* ================= SUBMIT ================= */}

            <Pressable
              style={[
                styles.button,
                (!isValid || isSubmitting) && {
                  opacity: 0.6,
                },
              ]}
              onPress={() => handleSubmit()}
              disabled={!isValid || isSubmitting}
            >
              <Text style={styles.buttonText}>
                {isSubmitting
                  ? "Saving..."
                  : isEditing
                    ? "Update Transaction"
                    : "Save Transaction"}
              </Text>
            </Pressable>

          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default TransactionForm;
