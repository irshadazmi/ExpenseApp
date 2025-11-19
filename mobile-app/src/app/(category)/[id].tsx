import React, { useEffect } from "react";
import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useNavigation, useLocalSearchParams } from "expo-router";
import CategoryForm from "@/components/category-form";

const EditCategory = () => {
  const navigation = useNavigation();
  const { id } = useLocalSearchParams();

  useEffect(() => {
    navigation.setOptions({ title: "Edit Category" });
  }, [navigation]);

  // CategoryForm expects a number for id
  const categoryId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Edit Category</Text>
      <CategoryForm id={categoryId} />
    </View>
  );
};

export default EditCategory;
