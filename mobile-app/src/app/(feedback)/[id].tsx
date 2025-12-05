import { View, Text, Pressable } from "react-native";
import { useRouter, useLocalSearchParams } from "expo-router";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import FeedbackForm from "@/components/feedback-form";

const EditFeedback = () => {
  const router = useRouter();
  const { id } = useLocalSearchParams();

  // Ensure proper number conversion for FeedbackForm
  const feedbackId = id ? Number(id) : undefined;

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
          Edit Feedback
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

      <FeedbackForm id={feedbackId} />
    </View>
  );
};

export default EditFeedback;
