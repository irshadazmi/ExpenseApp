// mobile-app/src/app/(account)/accounts.tsx
import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
  Alert,
} from "react-native";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { useAuth } from "@/contexts/auth-context";
import { useRouter, RelativePathString } from "expo-router";
import { accountService } from "@/services/account-service";
import { AccountResponse } from "@/types/account";

/* ======================================================
    ACCOUNTS LIST — MODERN CARD UX
====================================================== */

const Accounts = () => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const router = useRouter();
  const { user } = useAuth();

  const [accounts, setAccounts] =
    useState<AccountResponse[]>([]);
  const [loading, setLoading] = useState(false);

  const isSuperAdmin = user?.role_id === 1;
  const currentUserId = user?.id;

  /* ======================================================
      LOAD DATA
  ====================================================== */

  const loadAccounts = async () => {
    setLoading(true);

    try {
      const data = isSuperAdmin
        ? await accountService.getAll()
        : await accountService.getByUser(currentUserId!);

      setAccounts(data || []);
    } catch (error) {
      console.error("Failed to load accounts", error);
      Alert.alert(
        "Error",
        "Failed to load accounts. Please try again."
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadAccounts();
  }, []);

  /* ======================================================
      NAVIGATION ACTIONS
  ====================================================== */

  const handleAdd = () => {
    router.push("/(account)/add" as RelativePathString);
  };

  const handleEdit = (acc: AccountResponse) => {
    if (!acc.id) return;
    router.push(`/(account)/${acc.id}` as RelativePathString);
  };

  const handleDelete = async (acc: AccountResponse) => {
    if (!acc.id) return;

    Alert.alert(
      "Delete Account",
      `Are you sure you want to delete "${acc.name}"?`,
      [
        { text: "Cancel", style: "cancel" },
        {
          text: "Delete",
          style: "destructive",
          onPress: async () => {
            try {
              await accountService.delete(acc.id!);
              await loadAccounts();
            } catch {
              Alert.alert(
                "Error",
                "Could not delete account."
              );
            }
          },
        },
      ]
    );
  };

  /* ======================================================
      RENDER ITEM (CARD)
  ====================================================== */

  const renderItem = ({
    item,
  }: {
    item: AccountResponse;
  }) => (
    <View style={styles.card}>

      {/* HEADER */}
      <View style={styles.metaRow}>
        <Text style={styles.cardTitle}>
          {item.name}
        </Text>

        <Text
          style={[
            styles.txnAmt,
            {
              color:
                item.is_active === false
                  ? COLORS.danger
                  : COLORS.green,
            },
          ]}
        >
          ₹{Number(item.balance || 0).toLocaleString("en-IN")}
        </Text>
      </View>

      {/* META */}
      <View style={styles.metaRow}>
        <Text style={styles.metaText}>
          {item.type} · {item.currency}
        </Text>

        <Text
          style={[
            styles.metaText,
            {
              color:
                item.is_active === false
                  ? COLORS.danger
                  : COLORS.green,
              fontWeight: "600",
            },
          ]}
        >
          {item.is_active ? "Active" : "Inactive"}
        </Text>
      </View>

      {/* ACTIONS */}
      <View
        style={[
          styles.metaRow,
          {
            justifyContent: "flex-end",
            gap: 18,
            marginTop: 6,
          },
        ]}
      >
        <Pressable
          style={[
            styles.actionButton,
            styles.editButton,
          ]}
          onPress={() => handleEdit(item)}
        >
          <MaterialIcons
            name="edit"
            size={16}
            color={COLORS.white}
          />
        </Pressable>

        <Pressable
          style={[
            styles.actionButton,
            styles.deleteButton,
          ]}
          onPress={() => handleDelete(item)}
        >
          <MaterialIcons
            name="delete"
            size={16}
            color={COLORS.white}
          />
        </Pressable>
      </View>
    </View>
  );

  /* ======================================================
      MAIN RENDER
  ====================================================== */

  return (
    <View
      style={[
        styles.container,
        { paddingHorizontal: 16 },
      ]}
    >
      {/* HEADER */}
      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          marginBottom: 16,
        }}
      >
        <Text
          style={[
            styles.title,
            { flex: 1, marginBottom: 0 },
          ]}
        >
          List Of Accounts
        </Text>

        <Pressable onPress={handleAdd}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            + Add
          </Text>
        </Pressable>
      </View>

      {/* LIST */}
      {loading ? (
        <ActivityIndicator
          size="large"
          color={COLORS.primary}
          style={{ marginTop: 24 }}
        />
      ) : (
        <FlatList
          data={accounts}
          keyExtractor={(item) =>
            item.id?.toString() ??
            Math.random().toString()
          }
          renderItem={renderItem}
          refreshing={loading}
          onRefresh={loadAccounts}
          contentContainerStyle={{
            paddingBottom: 24,
          }}
          ListEmptyComponent={
            <View style={{ marginTop: 40 }}>
              <Text
                style={[
                  styles.text,
                  { textAlign: "center" },
                ]}
              >
                No accounts found.
              </Text>
            </View>
          }
        />
      )}
    </View>
  );
};

export default Accounts;
