import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  TextInput,
  ScrollView,
  Pressable,
  ActivityIndicator,
  Alert,
  KeyboardAvoidingView,
  Platform,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { budgetService } from "@/services/budget-service";
import { useAuth } from "@/contexts/auth-context";
import { BudgetResponse } from "@/types/budget";
import { router } from "expo-router";

/* ============================
   TYPES
============================ */

type EditableBudget = {
  id: number;
  name: string;
  category_id: number | null;
  amount: string;
  editable: boolean;
};

/* ============================
   HELPERS
============================ */

const calculateTotal = (items: EditableBudget[]) =>
  items
    .filter((b) => b.editable)
    .reduce((sum, b) => sum + Number(b.amount || 0), 0);

/* ============================
   COMPONENT
============================ */

const EditAllBudgets = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const { user } = useAuth();

  const [budgets, setBudgets] = useState<EditableBudget[]>([]);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);

  /* ======================================================
     LOAD DATA
  ====================================================== */

  useEffect(() => {
    if (!user) return;

    const load = async () => {
      try {
        setLoading(true);

        const budgetsData: BudgetResponse[] =
          await budgetService.getByUser(user.id);

        const rows: EditableBudget[] = budgetsData.map((b) => {
          const isTotal =
            b.category_id === null || b.category_id === 0;

          return {
            id: b.id,
            name: b.name,
            category_id: b.category_id,
            amount: b.amount.toString(),
            editable: !isTotal,
          };
        });

        const total = calculateTotal(rows);

        const finalRows = rows
          .map((b) =>
            b.editable ? b : { ...b, amount: total.toString() }
          )
          .sort((a, b) =>
            a.editable === b.editable ? 0 : a.editable ? -1 : 1
          );

        setBudgets(finalRows);
      } catch {
        Alert.alert("Error", "Failed to load budgets");
      } finally {
        setLoading(false);
      }
    };

    load();
  }, [user]);

  /* ======================================================
     SAVE
  ====================================================== */

  const handleSave = async () => {
    try {
      setSaving(true);

      const payload = {
        user_id: user!.id,
        budgets: budgets
          .map((b) => ({
            id: b.id,
            name: b.name,
            amount: Number(b.amount),
            category_id: b.category_id,
          })),
      };

      await budgetService.saveAllBudgets(payload);
      router.replace("/(budget)?status=success");
    } catch {
      router.replace("/(budget)?status=error");
    } finally {
      setSaving(false);
    }
  };

  /* ======================================================
     UI
  ====================================================== */

  if (loading) {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" color={COLORS.primary} />
      </View>
    );
  }

  return (
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === "ios" ? "padding" : undefined}
    >
      <View style={styles.container}>
        <ScrollView
          keyboardShouldPersistTaps="handled"
          showsVerticalScrollIndicator
          contentContainerStyle={{
            padding: 10,
            paddingBottom: 300, // space for button + keyboard
          }}
        >
          <Text
            style={[
              styles.title,
              { flex: 1, textAlign: "left", marginBottom: 15 },
            ]}
          >
            Edit All Budgets
          </Text>
          {budgets.map((b) => (
            <View
              key={b.id}
              style={{
                flexDirection: "row",
                alignItems: "center",
                marginBottom: 5,
                paddingVertical: 0,
                borderBottomWidth: 0.5,
                borderColor: COLORS.border,
              }}
            >
              {/* LABEL */}
              <Text
                style={{
                  flex: 1,
                  fontWeight: b.editable ? "500" : "700",
                  color: b.editable ? COLORS.text : COLORS.primary,
                }}
              >
                {b.name}
              </Text>

              {/* AMOUNT */}
              {b.editable ? (
                <View
                  style={{
                    flexDirection: "row",
                    alignItems: "center",
                    borderWidth: 1,
                    borderColor: COLORS.border,
                    borderRadius: 8,
                    paddingHorizontal: 8,
                    height: 42,
                    backgroundColor: COLORS.card,
                  }}
                >
                  <Text
                    style={{
                      marginRight: 4,
                      fontSize: 16,
                      color: COLORS.text,
                    }}
                  >
                    ₹
                  </Text>

                  <TextInput
                    style={{
                      width: 90,
                      textAlign: "right",
                      fontSize: 16,
                      color: COLORS.text,
                      paddingVertical: 0,
                    }}
                    keyboardType="numeric"
                    value={b.amount}
                    onChangeText={(v) => {
                      if (/^\d*\.?\d*$/.test(v)) {
                        setBudgets((prev) => {
                          const updated = prev.map((x) =>
                            x.id === b.id
                              ? { ...x, amount: v }
                              : x
                          );

                          const total =
                            calculateTotal(updated);

                          return updated.map((x) =>
                            x.editable
                              ? x
                              : {
                                ...x,
                                amount: total.toString(),
                              }
                          );
                        });
                      }
                    }}
                  />
                </View>
              ) : (
                <Text
                  style={{
                    fontWeight: "700",
                    color: COLORS.primary,
                    fontSize: 16,
                  }}
                >
                  ₹ {Number(b.amount).toLocaleString("en-IN")}
                </Text>
              )}
            </View>
          ))}

          {/* SAVE BUTTON */}
          <Pressable
            style={[
              styles.button,
              saving && { opacity: 0.6 },
            ]}
            disabled={saving}
            onPress={handleSave}
          >
            <Text style={styles.buttonText}>
              {saving ? "Saving..." : "Save Budgets"}
            </Text>
          </Pressable>
        </ScrollView>
      </View>
    </KeyboardAvoidingView>
  );
};

export default EditAllBudgets;
