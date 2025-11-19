import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
} from "react-native";
import styles from "@/styles/styles";
import { accountService } from "@/services/account-service";
import { COLORS } from "@/constants/COLORS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { AccountResponse } from "@/types/account";
import { RelativePathString, useRouter } from "expo-router";

const Accounts = () => {
  const [accounts, setAccounts] = useState<AccountResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const loadAccounts = async () => {
    try {
      setLoading(true);
      const res = await accountService.getAll(0, 100);
      console.log(res);
      setAccounts(res);
    } catch (err) {
      console.log("Failed to load accounts", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadAccounts();
  }, []);

  // Go to Add Account page (correct route path without parentheses)
  const handleAddAccount = () => {
    router.push('/(account)/add' as RelativePathString);
  };

  // Go to Edit/View Account page (correct route path without parentheses)
  const handleEdit = (acc: AccountResponse) => {
    if (acc.id !== undefined) {
      router.push(`/(account)/${acc.id}` as RelativePathString);
    } else {
      console.error("Account ID is undefined");
    }
  };

  // Delete account
  const handleDelete = async (acc: AccountResponse) => {
    if (acc.id !== undefined) {
      try {
        await accountService.delete(acc.id);
        await loadAccounts();
      } catch (err) {
        console.log("Failed to delete account", err);
      }
    }
  };

  const renderItem = ({ item, index }: { item: AccountResponse; index: number }) => (
    <View style={[
      styles.listRow,
      index % 2 === 1 && styles.listRowAlt, // alternate rows
    ]}>
      {/* Name */}
      <View style={{ flex: 2 }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.name}</Text>
      </View>
      {/* Is Active */}
      <View style={{ flex: 1, alignItems: "center" }}>
        <Text style={{ color: item.is_active ? "green" : "red" }}>
          {item.is_active ? "Active" : "Inactive"}
        </Text>
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
        <Text style={[styles.title, { flex: 1 }]}>Accounts</Text>
        <Pressable style={styles.button} onPress={handleAddAccount}>
          <Text style={styles.buttonText}>Add Account</Text>
        </Pressable>
      </View>

      {/* List header */}
      <View style={styles.listHeader}>
        <Text style={[styles.listHeaderText, { flex: 2, textAlign: "left" }]}>Name</Text>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "center" }]}>Active</Text>
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
          data={accounts}
          keyExtractor={item => item?.id?.toString() ?? ''}
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 16 }}
        />
      )}
    </View>
  );
};

export default Accounts;
