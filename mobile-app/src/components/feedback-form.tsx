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
import { useLocalSearchParams } from "expo-router";

import { Formik } from "formik";
import * as Yup from "yup";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { FEEDBACK_TYPES, STATUS_CODES } from "@/constants/CONSTANTS";
import { feedbackService } from "@/services/feedback-service";
import { useAuth } from "@/contexts/auth-context";
import { FeedbackResponse, FeedbackUpdate } from "@/types/feedback";
import { StatusCode } from "@/types/status";

/* ======================================================
   TYPES
====================================================== */

interface FeedbackFormProps {
  id?: number;
  mode?: "edit" | "reply";
  onSubmitSuccess?: () => void;
}

type FeedbackFormValues = {
  issue_type: string;
  subject: string;
  description: string;
  rating: number;
  status?: StatusCode;
  reply?: string;
  user_id?: number;
};

/* ======================================================
   VALIDATION
====================================================== */

const FeedbackSchema = Yup.object().shape({
  issue_type: Yup.string()
    .oneOf(FEEDBACK_TYPES)
    .required("Issue type is required"),

  subject: Yup.string()
    .trim()
    .required("Subject is required"),

  description: Yup.string()
    .trim()
    .required("Description is required"),

  rating: Yup.number()
    .min(1, "Rating must be at least 1")
    .max(5, "Rating cannot exceed 5")
    .required("Rating is required"),

  status: Yup.mixed<StatusCode>()
    .oneOf(STATUS_CODES as StatusCode[])
    .required("Status is required"),

  reply: Yup.string().optional(),
});

/* ======================================================
   COMPONENT
====================================================== */

const FeedbackForm: React.FC<FeedbackFormProps> = ({
  id,
  mode = "edit",
  onSubmitSuccess,
}) => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ theme-correct colors
  const { user } = useAuth();

  const isSuperAdmin = user?.role_id === 1;
  const userId = user?.id;

  const params = useLocalSearchParams<{ mode?: string }>();
  const effectiveMode =
    (params?.mode as "edit" | "reply") || mode;

  const isReplyMode = effectiveMode === "reply";
  const isEditing = typeof id === "number";

  const disableCoreFields = isReplyMode && isSuperAdmin;

  const [loading, setLoading] = useState(false);

  const [initialValues, setInitialValues] =
    useState<FeedbackFormValues>({
      issue_type: FEEDBACK_TYPES[0],
      subject: "",
      description: "",
      rating: 3,
      status: STATUS_CODES[0] as StatusCode,
      reply: "",
      user_id: userId,
    });

  /* ======================================================
     LOAD FEEDBACK
====================================================== */

  useEffect(() => {
    if (!isEditing) return;

    setLoading(true);

    feedbackService
      .getById(id!)
      .then((fb: FeedbackResponse) => {
        setInitialValues({
          issue_type: fb.issue_type,
          subject: fb.subject,
          description: fb.description,
          rating: fb.rating,
          status: fb.status as StatusCode,
          reply: fb.reply ?? "",
          user_id: fb.user_id,
        });
      })
      .catch(() =>
        Alert.alert("Error", "Failed to load feedback.")
      )
      .finally(() => setLoading(false));
  }, [id, isEditing]);

  /* ======================================================
     SUBMIT
====================================================== */

  const handleSubmit = async (
    values: FeedbackFormValues,
    { setSubmitting }: any
  ) => {
    try {
      if (isEditing) {
        const payload: FeedbackUpdate = {
          issue_type: values.issue_type,
          subject: values.subject,
          description: values.description,
          rating: values.rating,
          status: values.status,
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
        await feedbackService.create({
          ...values,
          user_id: userId,
        } as any);

        Alert.alert("Success", "Feedback submitted successfully.");
      }

      onSubmitSuccess?.();

    } catch {
      Alert.alert(
        "Error",
        "Failed to save feedback."
      );
    } finally {
      setSubmitting(false);
    }
  };

  /* ======================================================
     LOADING
====================================================== */

  if (loading) {
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
          Loading feedback...
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
        validationSchema={FeedbackSchema}
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

            {/* ================= ISSUE TYPE ================= */}

            <Text style={styles.label}>
              Issue Type
            </Text>

            <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
              {FEEDBACK_TYPES.map((t) => {
                const active = values.issue_type === t;

                return (
                  <Pressable
                    key={t}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue("issue_type", t)
                    }
                    disabled={disableCoreFields}
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active && styles.chipTextSelected,
                      ]}
                    >
                      {t}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.issue_type && errors.issue_type && (
              <Text style={styles.errorText}>
                {errors.issue_type}
              </Text>
            )}

            {/* ================= SUBJECT ================= */}

            <Text style={styles.label}>
              Subject
            </Text>

            <TextInput
              style={styles.textInput}
              placeholder="Enter subject"
              placeholderTextColor={COLORS.textMuted}
              value={values.subject}
              onChangeText={handleChange("subject")}
              editable={!disableCoreFields}
            />

            {touched.subject && errors.subject && (
              <Text style={styles.errorText}>
                {errors.subject}
              </Text>
            )}

            {/* ================= DESCRIPTION ================= */}

            <Text style={styles.label}>
              Description
            </Text>

            <TextInput
              style={[
                styles.textInput,
                {
                  height: 100,
                  textAlignVertical: "top",
                },
              ]}
              placeholder="Describe your issue"
              placeholderTextColor={COLORS.textMuted}
              multiline
              numberOfLines={4}
              value={values.description}
              onChangeText={handleChange("description")}
              editable={!disableCoreFields}
            />

            {touched.description && errors.description && (
              <Text style={styles.errorText}>
                {errors.description}
              </Text>
            )}

            {/* ================= RATING ================= */}

            <Text style={styles.label}>
              Rating (1–5)
            </Text>

            <TextInput
              style={styles.textInput}
              placeholder="1-5"
              placeholderTextColor={COLORS.textMuted}
              keyboardType="numeric"
              value={String(values.rating)}
              onChangeText={(v) =>
                setFieldValue("rating", Number(v))
              }
              editable={!disableCoreFields}
            />

            {touched.rating && errors.rating && (
              <Text style={styles.errorText}>
                {errors.rating}
              </Text>
            )}

            {/* ================= STATUS ================= */}

            <Text style={styles.label}>
              Status
            </Text>

            <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
              {STATUS_CODES.map((s) => {
                const active = values.status === s;

                return (
                  <Pressable
                    key={s}
                    style={[
                      styles.chip,
                      active && styles.chipSelected,
                    ]}
                    onPress={() =>
                      setFieldValue("status", s)
                    }
                    disabled={!isSuperAdmin}
                  >
                    <Text
                      style={[
                        styles.chipText,
                        active && styles.chipTextSelected,
                      ]}
                    >
                      {s}
                    </Text>
                  </Pressable>
                );
              })}
            </View>

            {touched.status && errors.status && (
              <Text style={styles.errorText}>
                {errors.status as string}
              </Text>
            )}

            {/* ================= REPLY ================= */}

            <Text style={styles.label}>
              Admin Reply
            </Text>

            <TextInput
              style={[
                styles.textInput,
                {
                  height: 80,
                  textAlignVertical: "top",
                },
              ]}
              placeholder="Admin reply"
              placeholderTextColor={COLORS.textMuted}
              multiline
              numberOfLines={3}
              value={values.reply ?? ""}
              onChangeText={handleChange("reply")}
              editable={isSuperAdmin}
            />

            {/* ================= SUBMIT ================= */}

            <Pressable
              style={[
                styles.button,
                (!isValid || isSubmitting) && { opacity: 0.6 },
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
