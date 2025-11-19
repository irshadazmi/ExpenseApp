// src/components/feedback-form.tsx
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
import { Picker } from "@react-native-picker/picker";
import { useLocalSearchParams } from "expo-router";
import { Formik } from "formik";
import * as Yup from "yup";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { FEEDBACK_TYPES, STATUS_CODES } from "@/constants/CONSTANTS";
import { feedbackService } from "@/services/feedback-service";
import { useAuth } from "@/contexts/auth-context";
import { FeedbackResponse, FeedbackUpdate } from "@/types/feedback";
import { StatusCode } from "@/types/status"; // ✅ import the type

interface FeedbackFormProps {
  id?: number;                 // from route
  mode?: "edit" | "reply";     // reply mode for SuperAdmin
  onSubmitSuccess?: () => void;
}

const FeedbackSchema = Yup.object().shape({
  issue_type: Yup.string()
    .oneOf(FEEDBACK_TYPES)
    .required("Issue type is required"),
  subject: Yup.string().trim().required("Subject is required"),
  description: Yup.string().trim().required("Description is required"),
  rating: Yup.number()
    .min(1, "Rating must be at least 1")
    .max(5, "Rating cannot exceed 5")
    .required("Rating is required"),
  status: Yup.mixed<StatusCode>()
    .oneOf(STATUS_CODES as StatusCode[])
    .required("Status is required"),
  reply: Yup.string().optional(),
});

type FeedbackFormValues = {
  issue_type: string;
  subject: string;
  description: string;
  rating: number | "";
  status?: StatusCode;        // ✅ match FeedbackUpdate
  reply?: string;
  user_id?: number;
};

const FeedbackForm: React.FC<FeedbackFormProps> = ({ id, mode = "edit", onSubmitSuccess }) => {
  const [loading, setLoading] = useState(false);
  const [initialValues, setInitialValues] = useState<FeedbackFormValues>({
    issue_type: FEEDBACK_TYPES[0],
    subject: "",
    description: "",
    rating: 3,
    status: STATUS_CODES[0] as StatusCode, // ✅ cast
    reply: "",
  });

  const { user } = useAuth();
  const roleId = user?.role_id;          // 1 = SuperAdmin
  const userId = user?.id;

  const isEditing = typeof id === "number";

  // If you also pass params via route:
  const params = useLocalSearchParams<{ mode?: string }>();
  const effectiveMode: "edit" | "reply" =
    (params?.mode as "edit" | "reply") || mode;

  const isSuperAdmin = roleId === 1;
  const isReplyMode = effectiveMode === "reply";

  useEffect(() => {
    if (isEditing) {
      setLoading(true);
      feedbackService
        .getById(id!)
        .then((feedback: FeedbackResponse) => {
          if (feedback) {
            setInitialValues({
              issue_type: feedback.issue_type,
              subject: feedback.subject,
              description: feedback.description,
              rating: feedback.rating,
              status: feedback.status as StatusCode,
              reply: feedback.reply ?? "",
              user_id: feedback.user_id,
            });
          }
        })
        .catch((error) => {
          console.error("Failed to load feedback", error);
          Alert.alert("Error", "Failed to load feedback data.");
        })
        .finally(() => setLoading(false));
    }
  }, [id, isEditing]);

  const handleSubmit = async (values: FeedbackFormValues, { setSubmitting }: any) => {
    try {
      setSubmitting(true);

      if (isEditing) {
        const payload: FeedbackUpdate = {
          issue_type: values.issue_type,
          subject: values.subject,
          description: values.description,
          rating: typeof values.rating === "number" ? values.rating : undefined,
          status: values.status, // ✅ StatusCode | undefined
          reply: values.reply,
          user_id: values.user_id ?? userId,
        };

        await feedbackService.update(id!, payload as any);
        Alert.alert(
          "Success",
          isReplyMode
            ? "Reply / status updated successfully."
            : "Feedback updated successfully."
        );
      } else {
        const createPayload = {
          issue_type: values.issue_type,
          subject: values.subject,
          description: values.description,
          rating: typeof values.rating === "number" ? values.rating : 0,
          status: (values.status ?? STATUS_CODES[0]) as StatusCode, // ✅ safe default
          reply: values.reply ?? "",
          user_id: userId,
        };
        await feedbackService.create(createPayload as any);
        Alert.alert("Success", "Feedback submitted successfully.");
      }

      if (onSubmitSuccess) onSubmitSuccess();
    } catch (error) {
      console.error("Failed to save feedback", error);
      Alert.alert("Error", "Failed to save feedback. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  if (loading && isEditing) {
    return (
      <View
        style={[
          styles.container,
          { justifyContent: "center", alignItems: "center" },
        ]}
      >
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={{ marginTop: 12 }}>Loading feedback...</Text>
      </View>
    );
  }

  const disableCoreFields = isReplyMode && isSuperAdmin;

  return (
    <ScrollView keyboardShouldPersistTaps="handled">
      <Formik<FeedbackFormValues>
        initialValues={initialValues}
        enableReinitialize
        validationSchema={FeedbackSchema}
        onSubmit={handleSubmit}
      >
        {({
          values,
          errors,
          touched,
          handleChange,
          handleSubmit,
          setFieldValue,
          isSubmitting,
          isValid,
        }) => (
          <View style={{ paddingBottom: 24 }}>
            {/* Issue Type */}
            <Text>Issue Type</Text>
            <View style={styles.dropdownWrapper}>
              <Picker
                selectedValue={values.issue_type}
                onValueChange={(v) => setFieldValue("issue_type", v)}
                style={styles.dropdown}
                dropdownIconColor={COLORS.primary}
                enabled={!disableCoreFields && !isSubmitting}
              >
                <Picker.Item
                  label="-- Select Type --"
                  value=""
                  color={COLORS.textSecondary}
                />
                {FEEDBACK_TYPES.map((t) => (
                  <Picker.Item key={t} label={t} value={t} />
                ))}
              </Picker>
            </View>
            {touched.issue_type && errors.issue_type && (
              <Text style={styles.errorText}>{errors.issue_type}</Text>
            )}

            {/* Subject */}
            <Text>Subject</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter subject"
              value={values.subject ?? ""}
              onChangeText={handleChange("subject")}
              editable={!disableCoreFields && !isSubmitting}
            />
            {touched.subject && errors.subject && (
              <Text style={styles.errorText}>{errors.subject}</Text>
            )}

            {/* Description */}
            <Text>Description</Text>
            <TextInput
              style={[styles.textInput, { height: 100, textAlignVertical: "top" }]}
              placeholder="Describe the issue / feedback"
              value={values.description ?? ""}
              onChangeText={handleChange("description")}
              multiline
              numberOfLines={4}
              editable={!disableCoreFields && !isSubmitting}
            />
            {touched.description && errors.description && (
              <Text style={styles.errorText}>{errors.description}</Text>
            )}

            {/* Rating */}
            <Text>Rating (1–5)</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter rating between 1 and 5"
              value={
                values.rating !== "" && values.rating !== undefined
                  ? String(values.rating)
                  : ""
              }
              onChangeText={(v) =>
                setFieldValue("rating", v ? Number(v) : "")
              }
              keyboardType="numeric"
              editable={!disableCoreFields && !isSubmitting}
            />
            {touched.rating && errors.rating && (
              <Text style={styles.errorText}>{errors.rating}</Text>
            )}

            {/* Status */}
            <Text>Status</Text>
            <View style={styles.dropdownWrapper}>
              <Picker
                selectedValue={values.status ?? (STATUS_CODES[0] as StatusCode)}
                onValueChange={(v) =>
                  setFieldValue("status", v as StatusCode) // ✅ cast string → StatusCode
                }
                style={styles.dropdown}
                dropdownIconColor={COLORS.primary}
                enabled={isSuperAdmin && !isSubmitting} // only SuperAdmin can change
              >
                {STATUS_CODES.map((s) => (
                  <Picker.Item key={s} label={s} value={s} />
                ))}
              </Picker>
            </View>
            {touched.status && errors.status && (
              <Text style={styles.errorText}>{errors.status as string}</Text>
            )}

            {/* Reply */}
            <Text>Reply (SuperAdmin)</Text>
            <TextInput
              style={[styles.textInput, { height: 80, textAlignVertical: "top" }]}
              placeholder="Admin reply or resolution note"
              value={values.reply ?? ""}
              onChangeText={handleChange("reply")}
              multiline
              numberOfLines={3}
              editable={isSuperAdmin && !isSubmitting}
            />
            {touched.reply && typeof errors.reply === "string" && (
              <Text style={styles.errorText}>{errors.reply}</Text>
            )}

            <Pressable
              style={[
                styles.button,
                !isValid || isSubmitting ? { opacity: 0.6 } : {},
                { marginTop: 16 },
              ]}
              onPress={() => handleSubmit()}
              disabled={!isValid || isSubmitting}
            >
              <Text style={styles.buttonText}>
                {isSubmitting
                  ? "Saving..."
                  : isEditing
                  ? isReplyMode
                    ? "Save Reply"
                    : "Update Feedback"
                  : "Submit Feedback"}
              </Text>
            </Pressable>
          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default FeedbackForm;
