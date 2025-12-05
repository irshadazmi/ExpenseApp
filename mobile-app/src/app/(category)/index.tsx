// mobile-app/src/app/(category)/index.tsx
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

import styles from "@/styles/styles";
import { categoryService } from "@/services/category-service";
import { COLORS } from "@/constants/COLORS";
import { CategoryResponse } from "@/types/category";
import { RelativePathString, useRouter } from "expo-router";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";

/* ======================================================
    CATEGORIES LIST
====================================================== */

const Categories = () => {
  const [categories, setCategories] = useState<CategoryResponse[]>([]);
  const [loading, setLoading] = useState(false);

  const router = useRouter();

  /* ======================================================
      LOAD DATA
  ====================================================== */

  const loadCategories = async () => {
    setLoading(true);

    try {
      const data = await categoryService.getAll();
      setCategories(data || []);
    } catch (err) {
      console.error("Failed to load categories", err);
      Alert.alert("Error", "Failed to load categories. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadCategories();
  }, []);

  /* ======================================================
      NAVIGATION
  ====================================================== */

  const handleAdd = () => {
    router.push("/(category)/add" as RelativePathString);
  };

  const handleEdit = (cat: CategoryResponse) => {
    if (typeof cat.id !== "number") return;

    const id = cat.id; // ✅ TS now knows this is number
    router.push(`/(category)/${id}` as RelativePathString);
  };

  const handleDelete = async (cat: CategoryResponse) => {
    if (typeof cat.id !== "number") return;

    const id = cat.id; // ✅ narrowed to number

    Alert.alert(
      "Confirm Delete",
      `Delete category "${cat.name}"?`,
      [
        { text: "Cancel", style: "cancel" },
        {
          text: "Delete",
          style: "destructive",
          onPress: async () => {
            try {
              await categoryService.delete(id); // ✅ no TS error
              loadCategories();
            } catch (err) {
              console.error("Failed to delete category", err);
              Alert.alert("Error", "Unable to delete category.");
            }
          },
        },
      ]
    );
  };

  /* ======================================================
      CATEGORY CARD
  ====================================================== */

  const renderItem = ({
    item,
  }: {
    item: CategoryResponse;
  }) => {
    return (
      <View style={styles.card}>
        <View style={styles.metaRow}>
          <Text style={styles.cardTitle}>{item.name}</Text>

          <Text
            style={[
              styles.statusText,
              {
                color: item.is_active
                  ? COLORS.green
                  : COLORS.red,
              },
            ]}
          >
            {item.is_active ? "Active" : "Inactive"}
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
      {/* ---------- HEADER ---------- */}
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
          Categories
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

      {/* ---------- LIST ---------- */}

      {loading ? (
        <ActivityIndicator
          style={{ marginTop: 24 }}
          size="small"
          color={COLORS.primary}
        />
      ) : (
        <FlatList
          data={categories}
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

export default Categories;
