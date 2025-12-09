// mobile-app/src/app/(transaction)/index.tsx

import React, { useEffect, useMemo, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
  Alert,
  TextInput,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { transactionService } from "@/services/transaction-service";
import { TransactionResponse } from "@/types/transaction";
import { RelativePathString, useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";

import { useAppColors } from "@/hooks/use-app-colors";

/* ======================================================
    TRANSACTIONS LIST
====================================================== */

const Transactions = () => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const [transactions, setTransactions] =
    useState<TransactionResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [search, setSearch] = useState("");

  const router = useRouter();
  const { user } = useAuth();

  const isSuperAdmin = user?.role_id === 1;
  const currentUserId = user?.id;

  /* ======================================================
      LOAD DATA
  ====================================================== */

  const loadTransactions = async () => {
    if (!currentUserId && !isSuperAdmin) return;

    setLoading(true);

    try {
      const data = isSuperAdmin
        ? await transactionService.getAll()
        : await transactionService.getByUser(currentUserId!);

      setTransactions(data || []);
    } catch (error) {
      console.error("Failed to load transactions", error);
      Alert.alert(
        "Error",
        "Failed to load transactions. Please try again."
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadTransactions();
  }, []);

  /* ======================================================
      SEARCH FILTER
  ====================================================== */

  const filteredTransactions = useMemo(() => {
    const q = search.trim().toLowerCase();

    if (!q) return transactions;

    return transactions.filter((t) => {
      return (
        t.description.toLowerCase().includes(q) ||
        t.type.toLowerCase().includes(q) ||
        t.currency.toLowerCase().includes(q) ||
        String(t.category_id).includes(q)
      );
    });
  }, [transactions, search]);

  /* ======================================================
      NAVIGATION
  ====================================================== */

  const handleAdd = () => {
    router.push("/(transaction)/add" as RelativePathString);
  };

  const handleEdit = (trx: TransactionResponse) => {
    if (!trx.id) return;

    router.push(
      `/(transaction)/${trx.id}` as RelativePathString
    );
  };

  const handleDelete = async (trx: TransactionResponse) => {
    if (!trx.id) return;

    try {
      await transactionService.delete(trx.id);
      loadTransactions();
    } catch (err) {
      console.error("Failed to delete transaction", err);
      Alert.alert("Error", "Unable to delete transaction.");
    }
  };

  /* ======================================================
      TRANSACTION ITEM
  ====================================================== */

  const renderItem = ({
    item,
  }: {
    item: TransactionResponse;
  }) => {
    const date = new Date(
      item.transaction_date
    ).toDateString();

    return (
      <View style={styles.card}>
        <View style={styles.metaRow}>
          <Text style={styles.cardTitle}>
            {item.description}
          </Text>

          <Text
            style={[
              styles.txnAmt,
              {
                color:
                  item.type === "Income"
                    ? COLORS.green
                    : item.type === "Transfer"
                    ? COLORS.blue
                    : COLORS.red,
              },
            ]}
          >
            {item.type === "Income" ? "+" : "-"}
            {item.currency}{" "}
            {item.amount.toLocaleString(
              "en-IN"
            )}
          </Text>
        </View>

        <View style={styles.metaRow}>
          <Text style={styles.metaText}>
            Category ID: {item.category_id}
          </Text>
          <Text style={styles.metaText}>
            {item.type}
          </Text>
        </View>

        <View style={styles.metaRow}>
          <Text style={styles.metaText}>
            Date: {date}
          </Text>
          <Text style={styles.metaText}>
            #{item.id}
          </Text>
        </View>

        <View style={styles.actionsRow}>
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
  };

  /* ======================================================
      RENDER
  ====================================================== */

  return (
    <View style={[styles.container, { paddingHorizontal: 16 }]}>
      {/* Header row: title + Add button */}
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
            { flex: 1, textAlign: "left", marginBottom: 0 },
          ]}
        >
          List Of Transactions
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

      {/* ---------- SEARCH ---------- */}

      <TextInput
        style={styles.searchInput}
        placeholder="Search by description, type, currency, or category..."
        value={search}
        onChangeText={setSearch}
      />

      {/* ---------- LIST ---------- */}

      {loading ? (
        <ActivityIndicator
          style={{ marginTop: 24 }}
          size="small"
          color={COLORS.primary}
        />
      ) : (
        <FlatList
          data={filteredTransactions}
          keyExtractor={(item) =>
            item.id?.toString() ?? ""
          }
          renderItem={renderItem}
          contentContainerStyle={{
            paddingBottom: 16,
          }}
          showsVerticalScrollIndicator={false}
        />
      )}
    </View>
  );
};

export default Transactions;
