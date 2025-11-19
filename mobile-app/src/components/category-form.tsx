// src/components/category-form.tsx
import React, { useEffect, useState } from "react";
import { View, Text, TextInput, Pressable, ScrollView, Alert, ActivityIndicator } from "react-native";
import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { categoryService } from "@/services/category-service";
import { Formik } from "formik";
import * as Yup from "yup";

export interface CategoryCreate {
  name: string;
  is_active: boolean;
}

const CategorySchema = Yup.object().shape({
  name: Yup.string()
    .trim()
    .required("Category name is required"),
  is_active: Yup.boolean(),
});

interface CategoryFormProps {
  id?: number; // optional category ID to edit
  onSubmitSuccess?: () => void;
}

const CategoryForm: React.FC<CategoryFormProps> = ({ id, onSubmitSuccess }) => {
  const [loading, setLoading] = useState(false);
  const [initialValues, setInitialValues] = useState<CategoryCreate>({
    name: "",
    is_active: true,
  });

  const isEditing = typeof id === "number";

  // Fetch existing category data for edit mode
  useEffect(() => {
		console.log("id:", id);
    if (isEditing) {
      setLoading(true);
      categoryService.getById(id!)
        .then(category => {
					console.log("API raw response:", category); // <- Check this!
          if (category) {
            setInitialValues({
              name: category.name,
              is_active: category.is_active,
            });
          }
        })
        .catch(error => {
          console.error("Failed to load category", error);
          Alert.alert("Error", "Failed to load category data.");
        })
        .finally(() => setLoading(false));
    }
  }, [id, isEditing]);

  const handleSubmit = async (values: CategoryCreate, { resetForm, setSubmitting }: any) => {
    try {
      setSubmitting(true);
      if (isEditing) {
        await categoryService.update(id!, values);
        Alert.alert("Success", "Category updated successfully.");
      } else {
        await categoryService.create(values);
        Alert.alert("Success", "Category added successfully.");
        resetForm(); // Reset form only on add mode
      }
      if (onSubmitSuccess) onSubmitSuccess();
    } catch (error) {
      console.error("Failed to save category", error);
      Alert.alert("Error", "Failed to save category. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  if (loading && isEditing) {
    // Only show loader while editing and still loading
    return (
      <View style={[styles.container, { justifyContent: "center", alignItems: "center" }]}>
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={{ marginTop: 12 }}>Loading category data...</Text>
      </View>
    );
  }

  return (
    <ScrollView>
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
          <View>
            <Text style={{ marginBottom: 8 }}>Name</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter category name"
              value={values.name}
              onChangeText={handleChange("name")}
              editable={!isSubmitting}
            />
            {touched.name && errors.name && (
              <Text style={styles.errorText}>{errors.name}</Text>
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

            <Pressable
              style={[styles.button, !isValid || isSubmitting ? { opacity: 0.6 } : {}]}
              onPress={() => handleSubmit()}
              disabled={!isValid || isSubmitting}
            >
              <Text style={styles.buttonText}>
                {isSubmitting ? "Saving..." : isEditing ? "Update Category" : "Save Category"}
              </Text>
            </Pressable>
          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default CategoryForm;
