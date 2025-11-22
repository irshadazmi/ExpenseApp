import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
  Alert,
} from "react-native";
import styles from "@/styles/styles";
import { transactionService } from "@/services/transaction-service";
import { COLORS } from "@/constants/COLORS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { TransactionResponse } from "@/types/transaction";
import { RelativePathString, useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";

const Transactions = () => {
  const [categories, setTransactions] = useState<TransactionResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const { user } = useAuth();

  const isSuperAdmin = user?.role_id === 1;
	const currentUserId = user?.id;

  const loadTransactions = async () => {
    setLoading(true);
    try {
      const data = isSuperAdmin
        ? await transactionService.getAll()
        : await transactionService.getByUser(currentUserId!);

      console.log(data);
      setTransactions(data);
    } catch (error) {
      console.error("Failed to load transactions", error);
      Alert.alert("Error", "Failed to load transactions. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadTransactions();
  }, []);

  // Go to Add Transaction page (correct route path without parentheses)
  const handleAddTransaction = () => {
    router.push('/(transaction)/add' as RelativePathString);
  };

  // Go to Edit/View Transaction page (correct route path without parentheses)
  const handleEdit = (exp: TransactionResponse) => {
    if (exp.id !== undefined) {
      router.push(`/(transaction)/${exp.id}` as RelativePathString);
    } else {
      console.error("Transaction ID is undefined");
    }
  };

  // Delete transaction
  const handleDelete = async (exp: TransactionResponse) => {
    if (exp.id !== undefined) {
      try {
        await transactionService.delete(exp.id);
        await loadTransactions();
      } catch (err) {
        console.log("Failed to delete transaction", err);
      }
    }
  };

  const renderItem = ({ item, index }: { item: TransactionResponse; index: number }) => (
    <View style={[
      styles.listRow,
      index % 2 === 1 && styles.listRowAlt, // alternate rows
    ]}>
      {/* Category */}
      <View style={{ flex: 1 }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.category_id}</Text>
      </View>
      {/* Description */}
      <View style={{ flex: 2 }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.description}</Text>
      </View>
      {/* Is Active */}
      <View style={{ flex: 1, alignItems: "center" }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.amount}</Text>
      </View>
      {/* Actions */}
      <View style={{
        flex: 1,
        flexDirection: "row",
        justifyContent: "flex-end",
        gap: 12,
      }}>
        <Pressable onPress={() => handleEdit(item)}>
          <MaterialIcons name="edit" size={22} color={COLORS.primary} />
        </Pressable>
        <Pressable onPress={() => handleDelete(item)}>
          <MaterialIcons name="delete" size={22} color={COLORS.danger} />
        </Pressable>
      </View>
    </View>
  );

  return (
    <View style={[styles.container, { paddingHorizontal: 16 }]}>
      {/* Header row: title + Add button */}
      <View style={{
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 16,
      }}>
        <Text style={[styles.title, { flex: 1 }]}>Transactions</Text>
        <Pressable style={styles.button} onPress={handleAddTransaction}>
          <Text style={styles.buttonText}>Add Transaction</Text>
        </Pressable>
      </View>

      {/* List header */}
      <View style={styles.listHeader}>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "left" }]}>Category</Text>
        <Text style={[styles.listHeaderText, { flex: 2, textAlign: "center" }]}>Description</Text>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "center" }]}>Amount</Text>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "right" }]}>Action</Text>
      </View>

      {loading ? (
        <ActivityIndicator
          style={{ marginTop: 16 }}
          size="small"
          color={COLORS.primary}
        />
      ) : (
        <FlatList
          data={categories}
          keyExtractor={item => item?.id?.toString() ?? ''}
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 16 }}
        />
      )}
    </View>
  );
};

export default Transactions;
