import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useLocalSearchParams } from "expo-router";
import FeedbackForm from "@/components/feedback-form";

const EditFeedback = () => {
	const { id } = useLocalSearchParams();
	// ExpenseForm expects a number for id
	const feedbackId = id ? Number(id) : undefined;

	return (
		<View style={styles.container}>
			<Text style={styles.title}>Edit Feedback</Text>
			<FeedbackForm id={feedbackId} />
		</View>
	);
};

export default EditFeedback;
