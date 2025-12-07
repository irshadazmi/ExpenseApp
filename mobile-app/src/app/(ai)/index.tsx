import { useState } from "react";
import { View, Text, TextInput, Pressable, FlatList } from "react-native";
import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import axios from "axios";

export default function AiAssistant() {
  const [input, setInput] = useState("");
  const [messages, setMessages] = useState<
    { role: "user" | "assistant"; text: string }[]
  >([]);
  const [loading, setLoading] = useState(false);

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage = { role: "user", text: input };

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setLoading(true);

    try {
      const res = await axios.post("http://localhost/api/ai/ask", {
        query: userMessage.text,
      });

      setMessages((prev) => [
        ...prev,
        { role: "assistant", text: res.data.reply },
      ]);
    } catch {
      setMessages((prev) => [
        ...prev,
        { role: "assistant", text: "AI is unavailable right now." },
      ]);
    }

    setLoading(false);
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={messages}
        keyExtractor={(_, i) => i.toString()}
        renderItem={({ item }) => (
          <View
            style={{
              alignSelf:
                item.role === "user" ? "flex-end" : "flex-start",
            }}
          >
            <Text
              style={{
                backgroundColor:
                  item.role === "user"
                    ? COLORS.primary
                    : "#EFEFEF",
                color:
                  item.role === "user"
                    ? "white"
                    : COLORS.text,
                padding: 12,
                borderRadius: 10,
                marginVertical: 4,
              }}
            >
              {item.text}
            </Text>
          </View>
        )}
      />

      <View style={{ flexDirection: "row" }}>
        <TextInput
          value={input}
          onChangeText={setInput}
          placeholder="Ask about your spending..."
          style={styles.textInput}
        />

        <Pressable onPress={sendMessage} style={styles.button}>
          <Text style={styles.buttonText}>
            {loading ? "..." : "Send"}
          </Text>
        </Pressable>
      </View>
    </View>
  );
}
