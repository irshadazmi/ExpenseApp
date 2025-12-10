// src/app/(feedback)/index.tsx

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

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { feedbackService } from "@/services/feedback-service";
import { FeedbackResponse } from "@/types/feedback";

import { FEEDBACK_TYPES, STATUS_CODES } from "@/constants/CONSTANTS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";

/* ======================================================
        FEEDBACK LIST
====================================================== */

const Feedbacks = () => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const router = useRouter();
  const { user } = useAuth();

  const [loading, setLoading] = useState(false);
  const [feedbacks, setFeedbacks] = useState<FeedbackResponse[]>([]);

  const [search, setSearch] = useState("");
  const [selectedType, setSelectedType] = useState<string | null>(null);
  const [selectedStatus, setSelectedStatus] = useState<string | null>(null);

  const isSuperAdmin = user?.role_id === 1;
  const currentUserId = user?.id;

  /* ======================================================
        LOAD DATA   (same pattern as Budget)
====================================================== */

  const loadFeedbacks = async () => {
    if (!user) return;

    setLoading(true);

    try {
      const data = isSuperAdmin
        ? await feedbackService.getAll()
        : await feedbackService.getByUser(currentUserId!);

      setFeedbacks(data || []);
    } catch (error) {
      console.error("Failed to load feedbacks", error);
      Alert.alert(
        "Error",
        "Failed to load feedbacks. Please try again."
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadFeedbacks();
  }, []);

  /* ======================================================
        SEARCH + FILTER
====================================================== */

  const filteredFeedbacks = useMemo(() => {
    let data = [...feedbacks];

    const q = search.trim().toLowerCase();

    if (q) {
      data = data.filter(
        (f) =>
          (f.subject ?? "").toLowerCase().includes(q) ||
          (f.description ?? "").toLowerCase().includes(q) ||
          (f.issue_type ?? "").toLowerCase().includes(q)
      );
    }

    if (selectedType)
      data = data.filter((f) => f.issue_type === selectedType);

    if (selectedStatus)
      data = data.filter((f) => f.status === selectedStatus);

    data.sort(
      (a, b) =>
        new Date(b.created_at).getTime() -
        new Date(a.created_at).getTime()
    );

    return data;
  }, [feedbacks, search, selectedType, selectedStatus]);

  /* ======================================================
        NAVIGATION
====================================================== */

  const handleAdd = () => {
    router.push("/(feedback)/add" as RelativePathString);
  };

  const handleEdit = (fb: FeedbackResponse) => {
    if (!fb.id) return;
    router.push(`/(feedback)/${fb.id}` as RelativePathString);
  };

  const handleReply = (fb: FeedbackResponse) => {
    if (!fb.id) return;

    router.push({
      pathname: `/(feedback)/${fb.id}` as RelativePathString,
      params: { id: String(fb.id), mode: "reply" },
    });
  };

  const handleDelete = async (fb: FeedbackResponse) => {
    if (!fb.id) return;

    Alert.alert(
      "Confirm Delete",
      "Are you sure you want to delete this feedback?",
      [
        { text: "Cancel", style: "cancel" },
        {
          text: "Delete",
          style: "destructive",
          onPress: async () => {
            try {
              await feedbackService.delete(fb.id!);
              await loadFeedbacks();
            } catch {
              Alert.alert("Error", "Failed to delete feedback.");
            }
          },
        },
      ]
    );
  };

  /* ======================================================
        FILTER CHIPS
====================================================== */

  const renderChip = (
    label: string,
    isActive: boolean,
    onPress: () => void
  ) => (
    <Pressable
      key={label}
      style={[
        styles.chip,
        isActive && styles.chipSelected,
      ]}
      onPress={onPress}
    >
      <Text
        style={[
          styles.chipText,
          isActive && styles.chipTextSelected,
        ]}
      >
        {label}
      </Text>
    </Pressable>
  );

  /* ======================================================
        FEEDBACK CARD
====================================================== */

  const renderItem = ({ item }: { item: FeedbackResponse }) => {
    const isOwner = currentUserId === item.user_id;
    const createdAt = new Date(item.created_at).toLocaleDateString();

    return (
      <View style={styles.card}>
        <View style={styles.cardHeader}>
          <Text style={styles.cardTitle}>
            {item.subject}
          </Text>

          <View style={styles.statusBadge}>
            <Text style={styles.statusText}>
              {item.status}
            </Text>
          </View>
        </View>

        <Text style={styles.issueType}>
          {item.issue_type}
        </Text>

        <Text style={styles.text}>
          {item.description}
        </Text>

        <View style={styles.metaRow}>
          <Text style={styles.metaText}>
            Rating: {item.rating} / 5
          </Text>
          <Text style={styles.metaText}>
            {createdAt}
          </Text>
        </View>

        {item.reply && (
          <View style={styles.replyBox}>
            <Text style={styles.replyLabel}>
              Admin Reply:
            </Text>
            <Text style={styles.replyText}>
              {item.reply}
            </Text>
          </View>
        )}

        <View style={styles.actionsRow}>
          {isOwner && (
            <>
              <Pressable
                style={[
                  styles.actionButton,
                  styles.editButton,
                ]}
                onPress={() => handleEdit(item)}
              >
                <MaterialIcons
                  name="edit"
                  size={16}
                  color={COLORS.white}
                />
              </Pressable>

              <Pressable
                style={[
                  styles.actionButton,
                  styles.deleteButton,
                ]}
                onPress={() => handleDelete(item)}
              >
                <MaterialIcons
                  name="delete"
                  size={16}
                  color={COLORS.white}
                />
              </Pressable>
            </>
          )}

          {isSuperAdmin && !item.reply && (
            <Pressable
              style={[
                styles.actionButton,
                styles.replyButton,
              ]}
              onPress={() => handleReply(item)}
            >
              <MaterialIcons
                name="reply"
                size={16}
                color={COLORS.white}
              />
            </Pressable>
          )}
        </View>
      </View>
    );
  };

  /* ======================================================
        UI   (Same structure as Budget)
====================================================== */

  return (
    <View style={styles.container}>
      {/* HEADER */}
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
            {
              flex: 1,
              textAlign: "left",
              marginBottom: 0,
            },
          ]}
        >
          List Of Feedbacks
        </Text>

        <Pressable onPress={handleAdd}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            + Add
          </Text>
        </Pressable>
      </View>

      {/* SEARCH */}
      <TextInput
        style={styles.searchInput}
        placeholder="Search feedback..."
        value={search}
        onChangeText={setSearch}
        placeholderTextColor={COLORS.textMuted}
      />

      {/* FILTER BY TYPE */}
      <Text style={styles.sectionLabel}>
        Filter by Type
      </Text>

      <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
        {renderChip(
          "All",
          selectedType === null,
          () => setSelectedType(null)
        )}

        {FEEDBACK_TYPES.map((t) =>
          renderChip(
            t,
            selectedType === t,
            () =>
              setSelectedType(
                selectedType === t ? null : t
              )
          )
        )}
      </View>

      {/* FILTER BY STATUS */}
      <Text style={styles.sectionLabel}>
        Filter by Status
      </Text>

      <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
        {renderChip(
          "All",
          selectedStatus === null,
          () => setSelectedStatus(null)
        )}

        {STATUS_CODES.map((s) =>
          renderChip(
            s,
            selectedStatus === s,
            () =>
              setSelectedStatus(
                selectedStatus === s ? null : s
              )
          )
        )}
      </View>

      {/* LIST */}
      {loading ? (
        <ActivityIndicator
          size="large"
          color={COLORS.primary}
          style={{ marginTop: 20 }}
        />
      ) : (
        <FlatList
          data={filteredFeedbacks}
          keyExtractor={(item) =>
            item.id?.toString() ??
            Math.random().toString()
          }
          renderItem={renderItem}
          refreshing={loading}
          onRefresh={loadFeedbacks}
          contentContainerStyle={{
            paddingBottom: 50,
          }}
          showsVerticalScrollIndicator={false}
        />
      )}
    </View>
  );
};

export default Feedbacks;
