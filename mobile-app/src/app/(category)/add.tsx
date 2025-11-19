// src/app/(drawer)/(category)/add.tsx
import { View, Text } from "react-native";
import styles from "@/styles/styles";
import CategoryForm from "@/components/category-form";

const AddCategory = () => {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Category</Text>
			<CategoryForm />
		</View>
	);
};

export default AddCategory;
