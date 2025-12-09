import { useState } from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  FlatList,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import axios from "axios";

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
  const COLORS = useAppColors(); // ✅ unified theme colors

  const [input, setInput] = useState("");
  const [messages, setMessages] = useState<Message[]>([]);
  const [loading, setLoading] = useState(false);

  /* ======================================================
      SEND MESSAGE
====================================================== */

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage: Message = {
      role: "user",
      text: input.trim(),
    };

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setLoading(true);

    try {
      const res = await axios.post("http://localhost/api/ai/ask", {
        query: userMessage.text,
      });

      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          text: res?.data?.reply ?? "No response from AI.",
        },
      ]);
    } catch {
      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          text: "AI is unavailable right now.",
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
      {/* ================= CHAT LIST ================= */}
      <FlatList
        data={messages}
        keyExtractor={(_, i) => i.toString()}
        contentContainerStyle={{
          paddingVertical: 8,
          paddingHorizontal: 6,
        }}
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
                borderRadius: 10,
                marginVertical: 4,
                lineHeight: 20,
              }}
            >
              {item.text}
            </Text>
          </View>
        )}
      />

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
        />

        <Pressable
          onPress={sendMessage}
          style={[
            styles.button,
            {
              paddingHorizontal: 14,
              paddingVertical: 10,
            },
            loading && { opacity: 0.6 },
          ]}
          disabled={loading}
        >
          <Text style={styles.buttonText}>
            {loading ? "..." : "Send"}
          </Text>
        </Pressable>
      </View>
    </View>
  );
}
