// src/app/(drawer)/(categories)/add.tsx
import { View, Text } from "react-native";
import styles from "@/styles/styles";
import CategoryForm from "@/components/category-form";
import { useEffect } from "react";
import { useNavigation } from "expo-router";

const AddCategory = () => {
	const navigation = useNavigation();
	useEffect(() => {
		navigation.setOptions({ title: "Add Category" });
	}, [navigation]);

	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Category</Text>
			<CategoryForm />
		</View>
	);
};

export default AddCategory;
