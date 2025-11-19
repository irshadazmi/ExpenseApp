// src/components/budget-form.tsx
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
import { BudgetCreate } from "@/types/budget";
import { categoryService } from "@/services/category-service";
import { COLORS } from "@/constants/COLORS";
import { budgetService } from "@/services/budget-service";
import { useAuth } from "@/contexts/auth-context";
import { Formik } from "formik";
import * as Yup from "yup";
import { CURRENCIES, PERIODS } from "@/constants/CONSTANTS";

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
    .oneOf(CURRENCIES as unknown as string[])
    .required("Currency is required"),
  start_date: Yup.date()
    .required("Start date is required"),
  end_date: Yup.date()
    .required("End date is required"),
  period: Yup.string()
    .oneOf(PERIODS as unknown as string[])
    .required("Period is required"),
  is_active: Yup.boolean(),
});

interface BudgetFormProps {
  id?: number; // optional budget ID for edit
  onSubmitSuccess?: () => void;
}

const BudgetForm: React.FC<BudgetFormProps> = ({ id, onSubmitSuccess }) => {
  const { user } = useAuth();
  const [categories, setCategories] = useState<any[]>([]);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [loading, setLoading] = useState(false);
  const [initialValues, setInitialValues] = useState<BudgetCreate | null>(null);
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

  // Load existing budget for edit mode
  useEffect(() => {
    if (!user) return;
    if (isEditing) {
      setLoading(true);
      budgetService.getById(id!)
        .then(budget => {
          if (budget) {
            setInitialValues({
              category_id: Number(budget.category_id) ?? 0,
              name: budget.name ?? "",
              amount: Number(budget.amount) ?? 0,
              currency: budget.currency ?? "INR",
              start_date: budget.start_date ?? new Date().toISOString(),
              end_date: budget.end_date ?? new Date().toISOString(),
              period: budget.period ?? "Monthly",
              user_id: user.id,
              is_active: Boolean(budget.is_active),
            });
          }
        })
        .catch(error => {
          console.error("Failed to load budget", error);
          Alert.alert("Error", "Failed to load budget data.");
        })
        .finally(() => setLoading(false));
    } else {
      setInitialValues({
        name: "",
        amount: 0,
        category_id: 0,
        currency: "INR",
        start_date: new Date().toISOString(),
        end_date: new Date().toISOString(),
        period: "Monthly",
        user_id: user.id,
        is_active: true
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
        <Text style={{ marginTop: 12 }}>Loading budget data...</Text>
      </View>
    );
  }

  const handleSubmit = async (
    values: BudgetCreate,
    { resetForm, setSubmitting }: any
  ) => {
    try {
      if (isEditing) {
        await budgetService.update(id!, values);
        Alert.alert("Success", "Budget updated successfully.");
      } else {
        await budgetService.create(values);
        Alert.alert("Success", "Budget created successfully.");
        resetForm();
      }
      if (onSubmitSuccess) onSubmitSuccess();
    } catch (error) {
      console.log("Error saving budget:", error);
      Alert.alert("Error", "Failed to save budget. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

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

            {/* Name */}
            <Text>Name</Text>
            <TextInput
              value={values.name}
              onChangeText={handleChange("name")}
              style={styles.textInput}
            />
            {touched.name && errors.name && (
              <Text style={styles.errorText}>{errors.name}</Text>
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

            {/* Period */}
            <Text>Period</Text>
            <View style={styles.dropdownWrapper}>
              <Picker
                selectedValue={values.period}
                onValueChange={handleChange("period")}
                style={styles.dropdown}
                dropdownIconColor={COLORS.primary}
              >
                <Picker.Item
                  label="-- Select Period --"
                  value={0}
                  color={COLORS.textSecondary}
                />
                {PERIODS.map(period => (
                  <Picker.Item key={period} label={period} value={period} />
                ))}
              </Picker>
            </View>
            {touched.period && errors.period && (
              <Text style={styles.errorText}>{errors.period}</Text>
            )}

            {/* Date Picker */}
            <Text>Start Date</Text>
            <Pressable
              onPress={() => setShowDatePicker(true)}
              style={[styles.textInput, styles.dateInput]}
            >
              <Text>
                {values.start_date
                  ? new Date(values.start_date).toISOString().split("T")[0]
                  : "Select Date"}
              </Text>
            </Pressable>

            {showDatePicker && (
              <DateTimePicker
                value={
                  values.start_date
                    ? new Date(values.start_date)
                    : new Date()
                }
                mode="date"
                display={Platform.OS === "ios" ? "spinner" : "default"}
                onChange={(event, selectedDate) => {
                  setShowDatePicker(false);
                  if (selectedDate) {
                    setFieldValue("start_date", selectedDate.toISOString());
                  }
                }}
              />
            )}
            {touched.start_date && errors.start_date && (
              <Text style={styles.errorText}>{errors.start_date as string}</Text>
            )}

            {/* Date Picker */}
            <Text>End Date</Text>
            <Pressable
              onPress={() => setShowDatePicker(true)}
              style={[styles.textInput, styles.dateInput]}
            >
              <Text>
                {values.end_date
                  ? new Date(values.end_date).toISOString().split("T")[0]
                  : "Select Date"}
              </Text>
            </Pressable>

            {showDatePicker && (
              <DateTimePicker
                value={
                  values.end_date
                    ? new Date(values.end_date)
                    : new Date()
                }
                mode="date"
                display={Platform.OS === "ios" ? "spinner" : "default"}
                onChange={(event, selectedDate) => {
                  setShowDatePicker(false);
                  if (selectedDate) {
                    setFieldValue("end_date", selectedDate.toISOString());
                  }
                }}
              />
            )}
            {touched.end_date && errors.end_date && (
              <Text style={styles.errorText}>{errors.end_date as string}</Text>
            )}

            {/* Active Toggle */}
            <View style={{ flexDirection: "row", alignItems: "center", marginVertical: 12 }}>
              <Text style={{ fontSize: 16, marginRight: 8 }}>Active</Text>
              <Pressable
                onPress={() => setFieldValue("is_active", !values.is_active)}
                style={{ padding: 4 }}
                disabled={isSubmitting}
              >
                <View
                  style={{
                    width: 24,
                    height: 24,
                    borderRadius: 12,
                    borderWidth: 2,
                    borderColor: COLORS.primary,
                    backgroundColor: values.is_active ? COLORS.primary : "transparent",
                  }}
                />
              </Pressable>
            </View>

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

