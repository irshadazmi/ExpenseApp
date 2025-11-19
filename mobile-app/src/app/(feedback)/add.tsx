// src/app/(drawer)/(category)/add.tsx
import { View, Text } from "react-native";
import styles from "@/styles/styles";
import FeedbackForm from "@/components/feedback-form";

const AddFeedback = () => {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Feedback</Text>
			<FeedbackForm />
		</View>
	);
};

export default AddFeedback;
