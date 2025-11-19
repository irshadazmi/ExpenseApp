// src/components/account-form.tsx
import React, { useEffect, useState } from "react";
import { View, Text, TextInput, Pressable, ScrollView, Alert, ActivityIndicator } from "react-native";
import { Picker } from "@react-native-picker/picker";
import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { accountService } from "@/services/account-service";
import { Formik } from "formik";
import * as Yup from "yup";
import { CURRENCIES } from "@/constants/CONSTANTS";
import { ACCOUNT_TYPES } from "@/constants/CONSTANTS";

export interface AccountCreate {
  name: string;
  type: string;
  balance: number;
  currency: string;
  is_active: boolean;
}

const AccountSchema = Yup.object().shape({
  name: Yup.string().trim().required("Account name is required"),
  type: Yup.string().oneOf(ACCOUNT_TYPES).required("Account type is required"),
  balance: Yup.number().typeError("Balance must be a number").required("Balance is required"),
  currency: Yup.string().oneOf(CURRENCIES).required("Currency is required"),
  is_active: Yup.boolean(),
});

interface AccountFormProps {
  id?: number;
  onSubmitSuccess?: () => void;
}

const AccountForm: React.FC<AccountFormProps> = ({ id, onSubmitSuccess }) => {
  const [loading, setLoading] = useState(false);
  const [initialValues, setInitialValues] = useState<AccountCreate>({
    name: "",
    type: "Checking",
    balance: 0,
    currency: "INR",
    is_active: true,
  });

  const isEditing = typeof id === "number";

  useEffect(() => {
    if (isEditing) {
      setLoading(true);
      accountService.getById(id!)
        .then(account => {
          if (account) {
            setInitialValues({
              name: account.name ?? "",
              type: account.type ?? "Checking",
              balance: Number(account.balance) ?? 0,
              currency: account.currency ?? "INR",
              is_active: account.is_active ?? true,
            });
          }
        })
        .catch(error => {
          console.error("Failed to load account", error);
          Alert.alert("Error", "Failed to load account data.");
        })
        .finally(() => setLoading(false));
    }
  }, [id, isEditing]);

  const handleSubmit = async (values: AccountCreate, { resetForm, setSubmitting }: any) => {
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
      if (onSubmitSuccess) onSubmitSuccess();
    } catch (error) {
      console.error("Failed to save account", error);
      Alert.alert("Error", "Failed to save account. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  if (loading && isEditing) {
    return (
      <View style={[styles.container, { justifyContent: "center", alignItems: "center" }]}>
        <ActivityIndicator size="large" color={COLORS.primary} />
        <Text style={{ marginTop: 12 }}>Loading account data...</Text>
      </View>
    );
  }

  return (
    <ScrollView>
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
          <View>
            {/* Account Name */}
            <Text>Name</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter account name"
              value={values.name}
              onChangeText={handleChange("name")}
              editable={!isSubmitting}
            />
            {touched.name && errors.name && (
              <Text style={styles.errorText}>{errors.name}</Text>
            )}

            {/* Account Type */}
            <Text>Type</Text>
            <View style={styles.dropdownWrapper}>
              <Picker
                selectedValue={values.type}
                onValueChange={handleChange("type")}
                style={styles.dropdown}
                dropdownIconColor={COLORS.primary}
              >
                <Picker.Item
                  label="-- Select Type --"
                  value={0}
                  color={COLORS.textSecondary}
                />
                {ACCOUNT_TYPES.map(type => (
                  <Picker.Item key={type} label={type} value={type} />
                ))}
              </Picker>
            </View>
            {touched.type && errors.type && (
              <Text style={styles.errorText}>{errors.type}</Text>
            )}

            {/* Balance */}
            <Text>Balance</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter balance"
              value={values.balance !== undefined ? String(values.balance) : ""}
              onChangeText={(v) => setFieldValue("balance", Number(v))}
              keyboardType="numeric"
              editable={!isSubmitting}
            />
            {touched.balance && errors.balance && (
              <Text style={styles.errorText}>{errors.balance}</Text>
            )}

            {/* Currency */}
            <Text>Currency</Text>
            <View style={styles.dropdownWrapper}>
              <Picker
                selectedValue={values.currency}
                onValueChange={handleChange("currency")}
                style={styles.dropdown}
                dropdownIconColor={COLORS.primary}
              >
                <Picker.Item
                  label="-- Select Currency --"
                  value={0}
                  color={COLORS.textSecondary}
                />
                {CURRENCIES.map(currency => (
                  <Picker.Item key={currency} label={currency} value={currency} />
                ))}
              </Picker>
            </View>
            {touched.currency && errors.currency && (
              <Text style={styles.errorText}>{errors.currency}</Text>
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
                {isSubmitting ? "Saving..." : isEditing ? "Update Account" : "Save Account"}
              </Text>
            </Pressable>
          </View>
        )}
      </Formik>
    </ScrollView>
  );
};

export default AccountForm;
