import { View, Text, Pressable } from "react-native";
import { useRouter, useLocalSearchParams } from "expo-router";

import { useStyles } from "@/styles/styles";
import CategoryForm from "@/components/category-form";
import { useAppColors } from "@/hooks/use-app-colors";

const EditCategory = () => {
  const styles = useStyles();
  const COLORS = useAppColors();  // ✅ central theme
  const router = useRouter();
  const { id } = useLocalSearchParams();

  // Ensure proper number conversion for CategoryForm
  const categoryId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      {/* Header: Title + Back */}
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
          Edit Category
        </Text>

        <Pressable onPress={() => router.back()}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            Back to List
          </Text>
        </Pressable>
      </View>

      <CategoryForm id={categoryId} />
    </View>
  );
};

export default EditCategory;
