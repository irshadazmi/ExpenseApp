// src/components/category-form.tsx

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

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { categoryService } from "@/services/category-service";

/* ======================================================
   TYPES
====================================================== */

export interface CategoryCreate {
  name: string;
  is_active: boolean;
}

interface CategoryFormProps {
  id?: number;
  onSubmitSuccess?: () => void;
}

/* ======================================================
   VALIDATION
====================================================== */

const CategorySchema = Yup.object().shape({
  name: Yup.string()
    .trim()
    .required("Category name is required"),

  is_active: Yup.boolean(),
});

/* ======================================================
   COMPONENT
====================================================== */

const CategoryForm: React.FC<CategoryFormProps> = ({
  id,
  onSubmitSuccess,
}) => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ Central dynamic theme colors

  const [loading, setLoading] = useState(false);

  const [initialValues, setInitialValues] =
    useState<CategoryCreate>({
      name: "",
      is_active: true,
    });

  const isEditing = typeof id === "number";

  /* ======================================================
     LOAD CATEGORY (EDIT MODE)
====================================================== */

  useEffect(() => {
    if (!isEditing) return;

    setLoading(true);

    categoryService
      .getById(id!)
      .then((category) => {
        if (!category) return;

        setInitialValues({
          name: category.name ?? "",
          is_active:
            typeof category.is_active === "boolean"
              ? category.is_active
              : true,
        });
      })
      .catch((error) => {
        console.error("Failed to load category", error);

        Alert.alert(
          "Error",
          "Failed to load category data."
        );
      })
      .finally(() => setLoading(false));
  }, [id, isEditing]);

  /* ======================================================
     SUBMIT HANDLER
====================================================== */

  const handleSubmit = async (
    values: CategoryCreate,
    { resetForm, setSubmitting }: any
  ) => {
    try {
      setSubmitting(true);

      if (isEditing) {
        await categoryService.update(id!, {
          id: id!,
          ...values,
        });

        Alert.alert(
          "Success",
          "Category updated successfully."
        );
      } else {
        await categoryService.create(values);

        Alert.alert(
          "Success",
          "Category added successfully."
        );

        resetForm();
      }

      onSubmitSuccess?.();

    } catch (error) {
      console.error("Failed to save category", error);

      Alert.alert(
        "Error",
        "Failed to save category. Please try again."
      );
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
        <ActivityIndicator
          size="large"
          color={COLORS.primary}
        />

        <Text style={{ marginTop: 12, color: COLORS.text }}>
          Loading category data…
        </Text>
      </View>
    );
  }

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
        validationSchema={CategorySchema}
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

            {/* ================= NAME ================= */}

            <Text style={styles.label}>
              Category Name
            </Text>

            <TextInput
              style={styles.textInput}
              placeholder="Enter category name"
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

            {/* ================= ACTIVE ================= */}

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
                style={{ marginLeft: 10 }}
                onPress={() =>
                  setFieldValue(
                    "is_active",
                    !values.is_active
                  )
                }
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

            {/* ================= SUBMIT ================= */}

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
                    ? "Update Category"
                    : "Save Category"}
              </Text>
            </Pressable>

          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default CategoryForm;
