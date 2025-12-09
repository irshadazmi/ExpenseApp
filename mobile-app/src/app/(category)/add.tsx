import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import CategoryForm from "@/components/category-form";

const AddCategory = () => {
  const styles = useStyles();
  const COLORS = useAppColors();    // ✅ central theme
  const router = useRouter();

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
          Add Category
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

      <CategoryForm />
    </View>
  );
};

export default AddCategory;
