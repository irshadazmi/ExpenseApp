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
import { categoryService } from "@/services/category-service";
import { COLORS } from "@/constants/COLORS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { CategoryResponse } from "@/types/category";
import { RelativePathString, useRouter } from "expo-router";

const Categories = () => {
  const [categories, setCategories] = useState<CategoryResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const loadCategories = async () => {
    try {
      setLoading(true);
      const res = await categoryService.getAll();
      setCategories(res);
    } catch (err) {
      console.log("Failed to load categories", err);
      Alert.alert("Error", "Failed to load categories. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadCategories();
  }, []);

  // Go to Add Category page (correct route path without parentheses)
  const handleAddCategory = () => {
    router.push('/(category)/add' as RelativePathString);
  };

  // Go to Edit/View Category page (correct route path without parentheses)
  const handleEdit = (cat: CategoryResponse) => {
    if (cat.id !== undefined) {
      router.push(`/(category)/${cat.id}` as RelativePathString);
    } else {
      console.error("Category ID is undefined");
    }
  };

  // Delete category
  const handleDelete = async (cat: CategoryResponse) => {
    if (cat.id !== undefined) {
      try {
        await categoryService.delete(cat.id);
        await loadCategories();
      } catch (err) {
        console.log("Failed to delete category", err);
      }
    }
  };

  const renderItem = ({ item, index }: { item: CategoryResponse; index: number }) => (
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
        <Text style={[styles.title, { flex: 1 }]}>Categories</Text>
        <Pressable style={styles.button} onPress={handleAddCategory}>
          <Text style={styles.buttonText}>Add Category</Text>
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
          data={categories}
          keyExtractor={item => item?.id?.toString() ?? ''}
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 16 }}
        />
      )}
    </View>
  );
};

export default Categories;
