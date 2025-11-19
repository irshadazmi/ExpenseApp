// src/app/(drawer)/(categories)/add.tsx
import { View, Text } from "react-native";
import styles from "@/styles/styles";
import FeedbackForm from "@/components/feedback-form";
import { useEffect } from "react";
import { useNavigation } from "expo-router";

const AddFeedback = () => {
	const navigation = useNavigation();
	useEffect(() => {
		navigation.setOptions({ title: "Add Feedback" });
	}, [navigation]);

	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Feedback</Text>
			<FeedbackForm />
		</View>
	);
};

export default AddFeedback;
