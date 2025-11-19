import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useLocalSearchParams } from "expo-router";
import CategoryForm from "@/components/category-form";

const EditCategory = () => {
  const { id } = useLocalSearchParams();
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
