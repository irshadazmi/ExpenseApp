// mobile-app/src/app/(ai)/index.tsx

import { useState } from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  FlatList,
  ActivityIndicator,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { useAuth } from "@/contexts/auth-context";

import { aiService } from "@/services/ai-service";

/* ======================================================
    FAQ QUICK PROMPTS
====================================================== */

const AI_FAQ = [
  "Total this month?",
  "Food spend?",
  "Over-budget category?",
  "Last 5 transactions?",
  "Remaining budget?",
  "Top spend category?",
];

/* ======================================================
    TYPES
====================================================== */

type Message = {
  role: "user" | "assistant";
  text: string;
};

/* ======================================================
    COMPONENT
====================================================== */

export default function AiAssistant() {
  const styles = useStyles();
  const COLORS = useAppColors();
  const { user } = useAuth();

  const [input, setInput] = useState("");
  const [messages, setMessages] = useState<Message[]>([]);
  const [loading, setLoading] = useState(false);

  /* ======================================================
      CLEAR CHAT
====================================================== */

  const clearChat = () => {
    setMessages([]);
  };

  /* ======================================================
      SEND MESSAGE
====================================================== */

  const sendMessage = async (text?: string) => {
    if (!user?.id || loading) return;

    const question = (text ?? input).trim();
    if (!question) return;

    const userMessage: Message = {
      role: "user",
      text: question,
    };

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setLoading(true);

    try {
      const res = await aiService.chat(user.id, question);

      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          text: res?.answer ?? "AI returned no response.",
        },
      ]);
    } catch (err) {
      console.error("AI error", err);

      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          text: "AI is unavailable right now. Please try again.",
        },
      ]);
    } finally {
      setLoading(false);
    }
  };

  /* ======================================================
      RENDER
====================================================== */

  return (
    <View style={styles.formContainer}>

      {/* ================= HEADER ================= */}

      <View
        style={{
          flexDirection: "row",
          justifyContent: "space-between",
          alignItems: "center",
          marginBottom: 6,
        }}
      >
        <Text
          style={{
            color: COLORS.textSecondary,
            fontSize: 13,
            fontWeight: "600",
          }}
        >
          AI Assistant
        </Text>

        {!!messages.length && (
          <Pressable onPress={clearChat}>
            <Text
              style={{
                color: COLORS.danger,
                fontSize: 13,
                fontWeight: "600",
              }}
            >
              Clear
            </Text>
          </Pressable>
        )}
      </View>

      {/* ================= CHAT LIST ================= */}

      <FlatList
        data={messages}
        keyExtractor={(_, i) => i.toString()}
        contentContainerStyle={{
          paddingVertical: 8,
          paddingHorizontal: 6,
          flexGrow: 1,
        }}
        showsVerticalScrollIndicator={false}
        renderItem={({ item }) => (
          <View
            style={{
              alignSelf:
                item.role === "user" ? "flex-end" : "flex-start",
              maxWidth: "85%",
            }}
          >
            <Text
              style={{
                backgroundColor:
                  item.role === "user"
                    ? COLORS.primary
                    : COLORS.surface,
                color:
                  item.role === "user"
                    ? COLORS.textInverse
                    : COLORS.text,
                paddingHorizontal: 12,
                paddingVertical: 8,
                borderRadius: 12,
                marginVertical: 4,
                lineHeight: 20,
                shadowColor: COLORS.cardShadow,
                shadowOpacity:
                  item.role === "assistant" ? 0.08 : 0.15,
                shadowOffset: { width: 0, height: 1 },
                shadowRadius: 2,
                elevation: 1,
              }}
            >
              {item.text}
            </Text>
          </View>
        )}
      />

      {/* ================= LOADING INDICATOR ================= */}

      {loading && (
        <View style={{ paddingVertical: 4 }}>
          <ActivityIndicator
            size="small"
            color={COLORS.primary}
          />
        </View>
      )}

      {/* ================= FAQ PROMPT ROW ================= */}

      <View style={{ marginVertical: 6 }}>
        <Text
          style={{
            color: COLORS.textSecondary,
            marginBottom: 6,
            fontSize: 12,
            fontWeight: "600",
          }}
        >
          Try asking:
        </Text>

        <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
          {AI_FAQ.map((item) => (
            <Pressable
              key={item}
              onPress={() => sendMessage(item)}
              style={styles.chip}
            >
              <Text style={styles.chipText}>
                {item}
              </Text>
            </Pressable>
          ))}
        </View>
      </View>

      {/* ================= INPUT BAR ================= */}

      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          gap: 8,
          marginTop: 6,
        }}
      >
        <TextInput
          value={input}
          onChangeText={setInput}
          placeholder="Ask about your spending..."
          placeholderTextColor={COLORS.textMuted}
          style={[
            styles.textInput,
            {
              flex: 1,
              marginBottom: 0,
            },
          ]}
          multiline
          returnKeyType="send"
          onSubmitEditing={() => sendMessage()}
        />

        <Pressable
          onPress={() => sendMessage()}
          disabled={loading}
          style={[
            styles.button,
            {
              paddingHorizontal: 14,
              paddingVertical: 10,
            },
            loading && {
              opacity: 0.6,
            },
          ]}
        >
          <Text style={styles.buttonText}>
            {loading ? "..." : "Send"}
          </Text>
        </Pressable>
      </View>
    </View>
  );
}
