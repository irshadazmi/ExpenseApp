// src/app/(drawer)/help-feedback/index.tsx
import React, { useEffect, useMemo, useState } from "react";
import {
	View,
	Text,
	TextInput,
	StyleSheet,
	ActivityIndicator,
	FlatList,
	Pressable,
	Alert,
} from "react-native";
import { RelativePathString, useNavigation, useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";
import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { feedbackService } from "@/services/feedback-service";
import { FeedbackResponse } from "@/types/feedback";
import { FEEDBACK_TYPES, STATUS_CODES } from "@/constants/CONSTANTS";

const Feedbacks = () => {
	const router = useRouter();
	const navigation = useNavigation();
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
		navigation.setOptions({
			title: 'Feedback',
		});

		const fetchFeedbacks = async () => {
			if (!user) return;

			setLoading(true);
			try {
				const data = isSuperAdmin
					? await feedbackService.getAll(0, 100)
					: await feedbackService.getByUser(currentUserId!);

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
			router.push(`/(feedbacks)/${id}` as RelativePathString);
		} else {
			console.error("Feedback ID is undefined");
		}
	};

	const handleReply = (id: number) => {
		// Use the same detail page for reply; it can show reply UI for SuperAdmin
		if (id !== undefined) {
			router.push({
			pathname: `/(feedbacks)/${id}` as RelativePathString,
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
				localStyles.chip,
				isSelected && localStyles.chipSelected,
			]}
			onPress={onPress}
		>
			<Text
				style={[
					localStyles.chipText,
					isSelected && localStyles.chipTextSelected,
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
			<View style={localStyles.card}>
				<View style={localStyles.cardHeader}>
					<Text style={localStyles.cardTitle}>{item.subject}</Text>
					<View style={localStyles.statusBadge}>
						<Text style={localStyles.statusText}>{statusLabel}</Text>
					</View>
				</View>

				<Text style={localStyles.issueType}>{item.issue_type}</Text>
				<Text style={localStyles.description}>{item.description}</Text>

				<View style={localStyles.metaRow}>
					<Text style={localStyles.metaText}>Rating: {item.rating} / 5</Text>
					<Text style={localStyles.metaText}>{createdAt}</Text>
				</View>

				{item.reply ? (
					<View style={localStyles.replyBox}>
						<Text style={localStyles.replyLabel}>Admin Reply:</Text>
						<Text style={localStyles.replyText}>{item.reply}</Text>
					</View>
				) : null}

				<View style={localStyles.actionsRow}>
					{/* Owner edit/delete */}
					{isOwner && (
						<>
							<Pressable
								style={[localStyles.actionButton, localStyles.editButton]}
								onPress={() => handleEdit(item.id)}
							>
								<Text style={localStyles.actionButtonText}>Edit</Text>
							</Pressable>
							<Pressable
								style={[localStyles.actionButton, localStyles.deleteButton]}
								onPress={() => handleDelete(item.id)}
							>
								<Text style={localStyles.actionButtonText}>Delete</Text>
							</Pressable>
						</>
					)}

					{/* SuperAdmin reply, only if no reply yet */}
					{isSuperAdmin && !item.reply && (
						<Pressable
							style={[localStyles.actionButton, localStyles.replyButton]}
							onPress={() => handleReply(item.id)}
						>
							<Text style={localStyles.actionButtonText}>Reply</Text>
						</Pressable>
					)}
				</View>
			</View>
		);
	};

	return (
		<View style={[styles.container, { paddingHorizontal: 12 }]}>
			<View style={localStyles.headerRow}>
				<Text style={styles.title}>Feedback</Text>
				<Pressable style={styles.button} onPress={handleAddFeedback}>
					<Text style={styles.buttonText}>+ New Feedback</Text>
				</Pressable>
			</View>

			{/* Search Bar */}
			<TextInput
				style={localStyles.searchInput}
				placeholder="Search by subject, description, or type..."
				value={searchTerm}
				onChangeText={setSearchTerm}
			/>

			{/* Filter chips for feedback type */}
			<Text style={localStyles.sectionLabel}>Filter by Type</Text>
			<View style={localStyles.chipsContainer}>
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
			<Text style={localStyles.sectionLabel}>Filter by Status</Text>
			<View style={localStyles.chipsContainer}>
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

const localStyles = StyleSheet.create({
	headerRow: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		marginBottom: 12,
	},
	searchInput: {
		borderWidth: 1,
		borderColor: "#ddd",
		borderRadius: 8,
		paddingHorizontal: 10,
		paddingVertical: 8,
		marginBottom: 12,
		backgroundColor: "#fff",
	},
	sectionLabel: {
		fontSize: 14,
		fontWeight: "600",
		marginBottom: 4,
		color: COLORS.textSecondary,
	},
	chipsContainer: {
		flexDirection: "row",
		flexWrap: "wrap",
		marginBottom: 8,
	},
	chip: {
		borderWidth: 1,
		borderColor: COLORS.primary,
		borderRadius: 16,
		paddingHorizontal: 10,
		paddingVertical: 4,
		marginRight: 6,
		marginBottom: 6,
		backgroundColor: "#fff",
	},
	chipSelected: {
		backgroundColor: COLORS.primary,
	},
	chipText: {
		fontSize: 12,
		color: COLORS.primary,
	},
	chipTextSelected: {
		color: COLORS.white,
	},
	card: {
		backgroundColor: COLORS.white,
		borderRadius: 10,
		padding: 12,
		marginBottom: 10,
		elevation: 2,
		shadowColor: "#000",
		shadowOpacity: 0.1,
		shadowRadius: 4,
		shadowOffset: { width: 0, height: 2 },
	},
	cardHeader: {
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "flex-start",
		marginBottom: 6,
	},
	cardTitle: {
		fontSize: 16,
		fontWeight: "700",
		flex: 1,
		marginRight: 8,
		color: COLORS.text,
	},
	statusBadge: {
		paddingHorizontal: 8,
		paddingVertical: 4,
		borderRadius: 12,
		backgroundColor: COLORS.secondary,
	},
	statusText: {
		fontSize: 10,
		fontWeight: "700",
		color: COLORS.textSecondary,
	},
	issueType: {
		fontSize: 13,
		fontWeight: "600",
		marginBottom: 4,
		color: COLORS.textSecondary,
	},
	description: {
		fontSize: 13,
		marginBottom: 8,
		color: COLORS.text,
	},
	metaRow: {
		flexDirection: "row",
		justifyContent: "space-between",
		marginBottom: 8,
	},
	metaText: {
		fontSize: 11,
		color: "#666",
	},
	replyBox: {
		backgroundColor: "#F5F0FF",
		borderRadius: 8,
		padding: 8,
		marginBottom: 8,
	},
	replyLabel: {
		fontSize: 12,
		fontWeight: "600",
		marginBottom: 2,
		color: COLORS.textSecondary,
	},
	replyText: {
		fontSize: 12,
		color: COLORS.text,
	},
	actionsRow: {
		flexDirection: "row",
		justifyContent: "flex-end",
		flexWrap: "wrap",
		gap: 8,
	} as any,
	actionButton: {
		paddingHorizontal: 10,
		paddingVertical: 6,
		borderRadius: 6,
		marginLeft: 8,
	},
	actionButtonText: {
		fontSize: 12,
		color: COLORS.white,
		fontWeight: "600",
	},
	editButton: {
		backgroundColor: "#3498db",
	},
	deleteButton: {
		backgroundColor: "#e74c3c",
	},
	replyButton: {
		backgroundColor: "#27ae60",
	},
});

export default Feedbacks;
