// src/components/budget-form.tsx
import DateTimePicker from "@react-native-community/datetimepicker";
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

import React, { useEffect, useState } from "react";
import styles from "@/styles/styles";

import { BudgetCreate } from "@/types/budget";
import { categoryService } from "@/services/category-service";
import { budgetService } from "@/services/budget-service";
import { useAuth } from "@/contexts/auth-context";

import { COLORS } from "@/constants/COLORS";
import { CURRENCIES, PERIODS } from "@/constants/CONSTANTS";

import { Formik } from "formik";
import * as Yup from "yup";

/* ======================================================
    VALIDATION
====================================================== */

const BudgetSchema = Yup.object().shape({
  category_id: Yup.number()
    .moreThan(0, "Category is required")
    .required("Category is required"),

  name: Yup.string()
    .trim()
    .required("Budget name is required"),

  amount: Yup.number()
    .typeError("Amount must be a number")
    .positive("Amount must be greater than zero")
    .required("Amount is required"),

  currency: Yup.string()
    .oneOf(CURRENCIES as string[])
    .required("Currency is required"),

  start_date: Yup.date().required("Start date is required"),

  end_date: Yup.date().required("End date is required"),

  period: Yup.string()
    .oneOf(PERIODS as string[])
    .required("Period is required"),

  is_active: Yup.boolean(),
});

/* ======================================================
    PROPS
====================================================== */

interface BudgetFormProps {
  id?: number;
  onSubmitSuccess?: () => void;
}

/* ======================================================
    COMPONENT
====================================================== */

const BudgetForm: React.FC<BudgetFormProps> = ({
  id,
  onSubmitSuccess,
}) => {
  const { user } = useAuth();

  const [categories, setCategories] = useState<any[]>([]);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [activeDateField, setActiveDateField] = useState<
    "start_date" | "end_date" | null
  >(null);

  const [loading, setLoading] = useState(false);
  const [initialValues, setInitialValues] =
    useState<BudgetCreate | null>(null);

  const isEditing = typeof id === "number";

  /* ======================================================
      LOAD CATEGORIES
  ====================================================== */

  useEffect(() => {
    categoryService
      .getAll()
      .then(setCategories)
      .catch((err) =>
        console.log("Failed to load categories", err)
      );
  }, []);

  /* ======================================================
      LOAD BUDGET FOR EDIT MODE
  ====================================================== */

  useEffect(() => {
    if (!user) return;

    if (!isEditing) {
      setInitialValues({
        name: "",
        amount: 0,
        category_id: 0,
        currency: "INR",
        start_date: new Date().toISOString(),
        end_date: new Date().toISOString(),
        period: "Monthly",
        user_id: user.id,
        is_active: true,
      });
      return;
    }

    setLoading(true);

    budgetService
      .getById(id!)
      .then((budget) => {
        if (!budget) return;

        setInitialValues({
          name: budget.name ?? "",
          amount: Number(budget.amount ?? 0),
          category_id: Number(budget.category_id ?? 0),
          currency: budget.currency ?? "INR",
          start_date:
            budget.start_date ?? new Date().toISOString(),
          end_date:
            budget.end_date ?? new Date().toISOString(),
          period: budget.period ?? "Monthly",
          user_id: user.id,
          is_active: Boolean(budget.is_active),
        });
      })
      .catch(() =>
        Alert.alert("Error", "Failed to load budget.")
      )
      .finally(() => setLoading(false));
  }, [id, user, isEditing]);

  /* ======================================================
      NOT LOGGED IN
  ====================================================== */

  if (!user) {
    return (
      <Text style={{ color: COLORS.danger }}>
        Please login again.
      </Text>
    );
  }

  if (!initialValues || (loading && isEditing)) {
    return (
      <View
        style={[
          styles.container,
          { justifyContent: "center", alignItems: "center" },
        ]}
      >
        <ActivityIndicator
          size="large"
          color={COLORS.primary}
        />
        <Text style={{ marginTop: 12 }}>
          Loading budget...
        </Text>
      </View>
    );
  }

  /* ======================================================
      SUBMIT HANDLER
  ====================================================== */

  const handleSubmit = async (
    values: BudgetCreate,
    { resetForm, setSubmitting }: any
  ) => {
    try {
      if (isEditing) {
        await budgetService.update(id!, values);
        Alert.alert("Success", "Budget updated");
      } else {
        await budgetService.create(values);
        Alert.alert("Success", "Budget created");
        resetForm();
      }

      onSubmitSuccess?.();
    } catch {
      Alert.alert("Error", "Failed to save budget");
    } finally {
      setSubmitting(false);
    }
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <ScrollView keyboardShouldPersistTaps="handled">
      <Formik
        initialValues={initialValues}
        enableReinitialize
        validationSchema={BudgetSchema}
        onSubmit={handleSubmit}
      >
        {({
          values,
          errors,
          touched,
          setFieldValue,
          handleChange,
          handleSubmit,
          isValid,
          isSubmitting,
        }) => (
          <View>

            {/* CATEGORY */}

            <Text style={styles.label}>Category</Text>

            <View
              style={[
                styles.chipsContainer,
                { flexWrap: "wrap" },
              ]}
            >
              {categories.map((c) => {
                const active =
                  values.category_id === c.id;

                return (
                  <Pressable
                    key={c.id}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    disabled={isSubmitting}
                    onPress={() =>
                      setFieldValue("category_id", c.id)
                    }
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active &&
                          styles.chipTextSelected,
                      ]}
                    >
                      {c.name}
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

            {/* NAME */}

            <Text style={styles.label}>Name</Text>

            <TextInput
              style={styles.textInput}
              value={values.name}
              onChangeText={handleChange("name")}
            />

            {touched.name && errors.name && (
              <Text style={styles.errorText}>
                {errors.name}
              </Text>
            )}

            {/* AMOUNT */}

            <Text style={styles.label}>Amount</Text>

            <TextInput
              style={styles.textInput}
              keyboardType="numeric"
              value={String(values.amount ?? "")}
              onChangeText={(v) =>
                setFieldValue("amount", Number(v))
              }
            />

            {touched.amount && errors.amount && (
              <Text style={styles.errorText}>
                {errors.amount}
              </Text>
            )}

            {/* CURRENCY */}

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
                    disabled={isSubmitting}
                    onPress={() =>
                      setFieldValue("currency", cur)
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

            {/* PERIOD */}

            <Text style={styles.label}>Period</Text>

            <View
              style={[
                styles.chipsContainer,
                { flexWrap: "wrap" },
              ]}
            >
              {PERIODS.map((p) => {
                const active =
                  values.period === p;

                return (
                  <Pressable
                    key={p}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    disabled={isSubmitting}
                    onPress={() =>
                      setFieldValue("period", p)
                    }
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active &&
                          styles.chipTextSelected,
                      ]}
                    >
                      {p}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.period && errors.period && (
              <Text style={styles.errorText}>
                {errors.period}
              </Text>
            )}

            {/* START DATE */}

            <Text style={styles.label}>Start Date</Text>
            <Pressable
              style={[styles.textInput, styles.dateInput]}
              onPress={() => {
                setActiveDateField("start_date");
                setShowDatePicker(true);
              }}
            >
              <Text style={styles.dateText}>
                {new Date(
                  values.start_date
                ).toISOString().split("T")[0]}
              </Text>
            </Pressable>

            {/* END DATE */}

            <Text style={styles.label}>End Date</Text>
            <Pressable
              style={[styles.textInput, styles.dateInput]}
              onPress={() => {
                setActiveDateField("end_date");
                setShowDatePicker(true);
              }}
            >
              <Text style={styles.dateText}>
                {new Date(
                  values.end_date
                ).toISOString().split("T")[0]}
              </Text>
            </Pressable>

            {showDatePicker && activeDateField && (
              <DateTimePicker
                value={
                  new Date(values[activeDateField])
                }
                mode="date"
                display={
                  Platform.OS === "ios"
                    ? "spinner"
                    : "default"
                }
                onChange={(_, date) => {
                  setShowDatePicker(false);
                  if (date) {
                    setFieldValue(
                      activeDateField,
                      date.toISOString()
                    );
                  }
                  setActiveDateField(null);
                }}
              />
            )}

            {/* ACTIVE */}

            <View
              style={{
                flexDirection: "row",
                alignItems: "center",
                marginVertical: 12,
              }}
            >
              <Text style={{ fontSize: 16 }}>
                Active
              </Text>
              <Pressable
                style={{ marginLeft: 10 }}
                onPress={() =>
                  setFieldValue(
                    "is_active",
                    !values.is_active
                  )
                }
              >
                <View
                  style={{
                    width: 24,
                    height: 24,
                    borderRadius: 12,
                    borderWidth: 2,
                    borderColor: COLORS.primary,
                    backgroundColor:
                      values.is_active
                        ? COLORS.primary
                        : "transparent",
                  }}
                />
              </Pressable>
            </View>

            {/* SUBMIT */}

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
                  ? "Update Budget"
                  : "Save Budget"}
              </Text>
            </Pressable>

          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default BudgetForm;
