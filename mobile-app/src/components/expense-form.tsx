// src/components/expense-form.tsx
import DateTimePicker from "@react-native-community/datetimepicker";
import { Picker } from "@react-native-picker/picker";
import {
  View,
  Text,
  TextInput,
  Pressable,
  Platform,
  ScrollView,
  ActivityIndicator,
  Alert
} from "react-native";
import React, { useEffect, useState } from "react";
import styles from "@/styles/styles";
import { ExpenseCreate } from "@/types/expense";
import { categoryService } from "@/services/category-service";
import { COLORS } from "@/constants/COLORS";
import { expenseService } from "@/services/expense-service";
import { useAuth } from "@/contexts/auth-context";
import { Formik } from "formik";
import * as Yup from "yup";
import { CURRENCIES } from "@/constants/CONSTANTS";
import { EXPENSE_TYPES } from "@/constants/CONSTANTS";

const ExpenseSchema = Yup.object().shape({
  description: Yup.string()
    .trim()
    .required("Description is required"),
  amount: Yup.number()
    .typeError("Amount must be a number")
    .positive("Amount must be greater than zero")
    .required("Amount is required"),
  category_id: Yup.number()
    .moreThan(0, "Category is required")
    .required("Category is required"),
  expense_date: Yup.date()
    .required("Expense date is required"),
  type: Yup.string()
    .oneOf(EXPENSE_TYPES as unknown as string[])
    .required("Type is required"),
  currency: Yup.string()
    .oneOf(CURRENCIES as unknown as string[])
    .required("Currency is required"),
});

interface ExpenseFormProps {
  id?: number; // optional expense ID for edit
  onSubmitSuccess?: () => void;
}

const ExpenseForm: React.FC<ExpenseFormProps> = ({ id, onSubmitSuccess }) => {
  const { user } = useAuth();
  const [categories, setCategories] = useState<any[]>([]);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [loading, setLoading] = useState(false);
  const [initialValues, setInitialValues] = useState<ExpenseCreate | null>(null);
  const isEditing = typeof id === "number";

  // Load categories once
  useEffect(() => {
    (async () => {
      try {
        const res = await categoryService.getAll();
        setCategories(res);
      } catch (err) {
        console.log("Failed to load categories", err);
      }
    })();
  }, []);

  // Load existing expense for edit mode
  useEffect(() => {
    if (!user) return;
    if (isEditing) {
      setLoading(true);
      expenseService.getById(id!)
        .then(expense => {
          if (expense) {
            setInitialValues({
              description: expense.description ?? "",
              amount: Number(expense.amount) ?? 0,
              category_id: Number(expense.category_id) ?? 0,
              type: expense.type ?? "Expense",
              currency: expense.currency ?? "INR",
              expense_date: expense.expense_date ?? new Date().toISOString(),
              user_id: user.id,
            });
          }
        })
        .catch(error => {
          console.error("Failed to load expense", error);
          Alert.alert("Error", "Failed to load expense data.");
        })
        .finally(() => setLoading(false));
    } else {
      setInitialValues({
        description: "",
        amount: 0,
        category_id: 0,
        type: "Expense",
        currency: "INR",
        expense_date: new Date().toISOString(),
        user_id: user.id,
      });
    }
  }, [id, isEditing, user]);

  if (!user) {
    return (
      <View>
        <Text style={{ color: COLORS.danger }}>
          Please login again. User information is not available.
        </Text>
      </View>
    );
  }

  if (!initialValues || (isEditing && loading)) {
    return (
      <View style={[styles.container, { justifyContent: "center", alignItems: "center" }]}>
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={{ marginTop: 12 }}>Loading expense data...</Text>
      </View>
    );
  }

  const handleSubmit = async (
    values: ExpenseCreate,
    { resetForm, setSubmitting }: any
  ) => {
    try {
      if (isEditing) {
        await expenseService.update(id!, values);
        Alert.alert("Success", "Expense updated successfully.");
      } else {
        await expenseService.create(values);
        Alert.alert("Success", "Expense created successfully.");
        resetForm();
      }
      if (onSubmitSuccess) onSubmitSuccess();
    } catch (error) {
      console.log("Error saving expense:", error);
      Alert.alert("Error", "Failed to save expense. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <ScrollView keyboardShouldPersistTaps="handled">
      <Formik
        initialValues={initialValues}
        enableReinitialize
        validationSchema={ExpenseSchema}
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
          <View>
            {/* Category Dropdown */}
            <Text>Category</Text>
            <View style={styles.dropdownWrapper}>
              <Picker
                selectedValue={values.category_id}
                onValueChange={(v) => setFieldValue("category_id", v)}
                style={styles.dropdown}
                dropdownIconColor={COLORS.primary}
              >
                <Picker.Item
                  label="-- Select Category --"
                  value={0}
                  color={COLORS.textSecondary}
                />
                {categories.map((cat: { id: number; name: string }) => (
                  <Picker.Item
                    key={cat.id}
                    label={cat.name}
                    value={cat.id}
                    color={COLORS.text}
                    style={styles.dropdownText}
                  />
                ))}
              </Picker>
            </View>
            {touched.category_id && errors.category_id && (
              <Text style={styles.errorText}>{errors.category_id}</Text>
            )}

            {/* Type Radio Buttons */}
            <Text>Type</Text>
            <View style={styles.radioGroup}>
              {EXPENSE_TYPES.map((t) => (
                <Pressable
                  key={t}
                  style={styles.radioOption}
                  onPress={() => setFieldValue("type", t)}
                >
                  <View
                    style={[
                      styles.radioOuter,
                      values.type === t && styles.radioOuterSelected,
                    ]}
                  >
                    {values.type === t && <View style={styles.radioInner} />}
                  </View>
                  <Text
                    style={[
                      styles.radioLabel,
                      values.type === t && styles.radioLabelSelected,
                    ]}
                  >
                    {t}
                  </Text>
                </Pressable>
              ))}
            </View>
            {touched.type && errors.type && (
              <Text style={styles.errorText}>{errors.type}</Text>
            )}

            {/* Currency Radio Buttons */}
            <Text>Currency</Text>
            <View style={styles.radioGroup}>
              {CURRENCIES.map((cur) => (
                <Pressable
                  key={cur}
                  style={styles.radioOption}
                  onPress={() => setFieldValue("currency", cur)}
                >
                  <View
                    style={[
                      styles.radioOuter,
                      values.currency === cur && styles.radioOuterSelected,
                    ]}
                  >
                    {values.currency === cur && (
                      <View style={styles.radioInner} />
                    )}
                  </View>
                  <Text
                    style={[
                      styles.radioLabel,
                      values.currency === cur && styles.radioLabelSelected,
                    ]}
                  >
                    {cur}
                  </Text>
                </Pressable>
              ))}
            </View>
            {touched.currency && errors.currency && (
              <Text style={styles.errorText}>{errors.currency}</Text>
            )}

            {/* Description */}
            <Text>Description</Text>
            <TextInput
              value={values.description}
              onChangeText={handleChange("description")}
              style={styles.textInput}
            />
            {touched.description && errors.description && (
              <Text style={styles.errorText}>{errors.description}</Text>
            )}

            {/* Amount */}
            <Text>Amount</Text>
            <TextInput
              value={
                values.amount !== undefined && values.amount !== null
                  ? String(values.amount)
                  : ""
              }
              onChangeText={(v) => setFieldValue("amount", v)}
              keyboardType="numeric"
              style={styles.textInput}
            />
            {touched.amount && errors.amount && (
              <Text style={styles.errorText}>{errors.amount}</Text>
            )}

            {/* Date Picker */}
            <Text>Expense Date</Text>
            <Pressable
              onPress={() => setShowDatePicker(true)}
              style={[styles.textInput, styles.dateInput]}
            >
              <Text>
                {values.expense_date
                  ? new Date(values.expense_date).toISOString().split("T")[0]
                  : "Select Date"}
              </Text>
            </Pressable>

            {showDatePicker && (
              <DateTimePicker
                value={
                  values.expense_date
                    ? new Date(values.expense_date)
                    : new Date()
                }
                mode="date"
                display={Platform.OS === "ios" ? "spinner" : "default"}
                onChange={(event, selectedDate) => {
                  setShowDatePicker(false);
                  if (selectedDate) {
                    setFieldValue("expense_date", selectedDate.toISOString());
                  }
                }}
              />
            )}
            {touched.expense_date && errors.expense_date && (
              <Text style={styles.errorText}>{errors.expense_date as string}</Text>
            )}

            {/* Submit Button */}
            <Pressable
              style={
                isValid && !isSubmitting
                  ? styles.button
                  : styles.disabledButton
              }
              onPress={() => handleSubmit()}
              disabled={!isValid || isSubmitting}
            >
              <Text
                style={
                  isValid && !isSubmitting
                    ? styles.buttonText
                    : styles.disabledButtonText
                }
              >
                {isSubmitting
                  ? "Saving..."
                  : isEditing
                  ? "Update Expense"
                  : "Save Expense"}
              </Text>
            </Pressable>
          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default ExpenseForm;
