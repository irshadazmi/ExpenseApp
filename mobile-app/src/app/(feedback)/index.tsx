// src/app/(drawer)/help-feedback/index.tsx
import React, { useEffect, useMemo, useState } from "react";
import {
	View,
	Text,
	TextInput,
	ActivityIndicator,
	FlatList,
	Pressable,
	Alert,
} from "react-native";
import { RelativePathString, useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";
import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { feedbackService } from "@/services/feedback-service";
import { FeedbackResponse } from "@/types/feedback";
import { FEEDBACK_TYPES, STATUS_CODES } from "@/constants/CONSTANTS";

const Feedbacks = () => {
	const router = useRouter();
	const { user } = useAuth();
	const [loading, setLoading] = useState(false);
	const [feedbacks, setFeedbacks] = useState<FeedbackResponse[]>([]);
	const [searchTerm, setSearchTerm] = useState("");
	const [selectedType, setSelectedType] = useState<string | null>(null);
	const [selectedStatus, setSelectedStatus] = useState<string | null>(null);

	const isSuperAdmin = user?.role_id === 1;
	const currentUserId = user?.id;

	// Load feedbacks on mount & when user/role changes
	useEffect(() => {
		const fetchFeedbacks = async () => {
			console.log(user);
			if (!user) return;

			setLoading(true);
			try {
				const data = isSuperAdmin
					? await feedbackService.getAll()
					: await feedbackService.getByUser(currentUserId!);

				console.log(data);
				setFeedbacks(data);
			} catch (error) {
				console.error("Failed to load feedbacks", error);
				Alert.alert("Error", "Failed to load feedbacks. Please try again.");
			} finally {
				setLoading(false);
			}
		};

		fetchFeedbacks();
	}, [user, isSuperAdmin, currentUserId]);

	const handleDelete = async (id: number) => {
		Alert.alert("Confirm Delete", "Are you sure you want to delete this feedback?", [
			{ text: "Cancel", style: "cancel" },
			{
				text: "Delete",
				style: "destructive",
				onPress: async () => {
					try {
						await feedbackService.delete(id);
						setFeedbacks((prev) => prev.filter((fb) => fb.id !== id));
					} catch (error) {
						console.error("Failed to delete feedback", error);
						Alert.alert("Error", "Failed to delete feedback.");
					}
				},
			},
		]);
	};

	const handleEdit = (id: number) => {
		if (id !== undefined) {
			router.push(`/(feedback)/${id}` as RelativePathString);
		} else {
			console.error("Feedback ID is undefined");
		}
	};

	const handleReply = (id: number) => {
		// Use the same detail page for reply; it can show reply UI for SuperAdmin
		if (id !== undefined) {
			router.push({
			pathname: `/(feedback)/${id}` as RelativePathString,
			params: { id: String(id), mode: "reply" },
		});
		} else {
			console.error("Feedback ID is undefined");
		}
	};

	const handleAddFeedback = () => {
		// Assuming new feedback route: /(drawer)/help-feedback/new.tsx
		router.push("/(drawer)/help-feedback/new");
	};

	// Filtering logic: search + type + status
	const filteredFeedbacks = useMemo(() => {
		let data = [...feedbacks];

		if (searchTerm.trim()) {
			const term = searchTerm.toLowerCase();
			data = data.filter(
				(fb) =>
					fb.subject.toLowerCase().includes(term) ||
					fb.description.toLowerCase().includes(term) ||
					fb.issue_type.toLowerCase().includes(term)
			);
		}

		if (selectedType) {
			data = data.filter((fb) => fb.issue_type === selectedType);
		}

		if (selectedStatus) {
			data = data.filter((fb) => fb.status === selectedStatus);
		}

		// Newest first
		data.sort(
			(a, b) =>
				new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
		);

		return data;
	}, [feedbacks, searchTerm, selectedType, selectedStatus]);

	const renderChip = (
		label: string,
		isSelected: boolean,
		onPress: () => void
	) => (
		<Pressable
			key={label}
			style={[
				styles.chip,
				isSelected && styles.chipSelected,
			]}
			onPress={onPress}
		>
			<Text
				style={[
					styles.chipText,
					isSelected && styles.chipTextSelected,
				]}
			>
				{label}
			</Text>
		</Pressable>
	);

	const renderFeedbackCard = ({ item }: { item: FeedbackResponse }) => {
		const isOwner = currentUserId === item.user_id;
		const createdAt = new Date(item.created_at).toLocaleString();
		const statusLabel = item.status; // Already a string from STATUS_CODES

		return (
			<View style={styles.card}>
				<View style={styles.cardHeader}>
					<Text style={styles.cardTitle}>{item.subject}</Text>
					<View style={styles.statusBadge}>
						<Text style={styles.statusText}>{statusLabel}</Text>
					</View>
				</View>

				<Text style={styles.issueType}>{item.issue_type}</Text>
				<Text style={styles.description}>{item.description}</Text>

				<View style={styles.metaRow}>
					<Text style={styles.metaText}>Rating: {item.rating} / 5</Text>
					<Text style={styles.metaText}>{createdAt}</Text>
				</View>

				{item.reply ? (
					<View style={styles.replyBox}>
						<Text style={styles.replyLabel}>Admin Reply:</Text>
						<Text style={styles.replyText}>{item.reply}</Text>
					</View>
				) : null}

				<View style={styles.actionsRow}>
					{/* Owner edit/delete */}
					{isOwner && (
						<>
							<Pressable
								style={[styles.actionButton, styles.editButton]}
								onPress={() => handleEdit(item.id)}
							>
								<Text style={styles.actionButtonText}>Edit</Text>
							</Pressable>
							<Pressable
								style={[styles.actionButton, styles.deleteButton]}
								onPress={() => handleDelete(item.id)}
							>
								<Text style={styles.actionButtonText}>Delete</Text>
							</Pressable>
						</>
					)}

					{/* SuperAdmin reply, only if no reply yet */}
					{isSuperAdmin && !item.reply && (
						<Pressable
							style={[styles.actionButton, styles.replyButton]}
							onPress={() => handleReply(item.id)}
						>
							<Text style={styles.actionButtonText}>Reply</Text>
						</Pressable>
					)}
				</View>
			</View>
		);
	};

	return (
		<View style={[styles.container, { paddingHorizontal: 16 }]}>
      {/* Header row: title + Add button */}
      <View style={{
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 16,
      }}>
        <Text style={[styles.title, { flex: 1 }]}>Feedback</Text>
        <Pressable style={styles.button} onPress={handleAddFeedback}>
          <Text style={styles.buttonText}>Add Feedback</Text>
        </Pressable>
      </View>

			{/* Search Bar */}
			<TextInput
				style={styles.searchInput}
				placeholder="Search by subject, description, or type..."
				value={searchTerm}
				onChangeText={setSearchTerm}
			/>

			{/* Filter chips for feedback type */}
			<Text style={styles.sectionLabel}>Filter by Type</Text>
			<View style={styles.chipsContainer}>
				{renderChip(
					"All",
					selectedType === null,
					() => setSelectedType(null)
				)}
				{FEEDBACK_TYPES.map((type) =>
					renderChip(
						type,
						selectedType === type,
						() => setSelectedType(selectedType === type ? null : type)
					)
				)}
			</View>

			{/* Filter chips for status */}
			<Text style={styles.sectionLabel}>Filter by Status</Text>
			<View style={styles.chipsContainer}>
				{renderChip(
					"All",
					selectedStatus === null,
					() => setSelectedStatus(null)
				)}
				{STATUS_CODES.map((status) =>
					renderChip(
						status,
						selectedStatus === status,
						() =>
							setSelectedStatus(selectedStatus === status ? null : status)
					)
				)}
			</View>

			{loading ? (
				<ActivityIndicator
					style={{ marginTop: 16 }}
					size="small"
					color={COLORS.primary}
				/>
			) : filteredFeedbacks.length === 0 ? (
				<Text style={{ marginTop: 16, textAlign: "center" }}>
					No feedbacks found.
				</Text>
			) : (
				<FlatList
					data={filteredFeedbacks}
					keyExtractor={(item) => item.id.toString()}
					renderItem={renderFeedbackCard}
					contentContainerStyle={{ paddingVertical: 12, paddingBottom: 32 }}
				/>
			)}
		</View>
	);
};

export default Feedbacks;
