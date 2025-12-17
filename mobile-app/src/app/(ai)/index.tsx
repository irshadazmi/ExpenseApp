import { useState } from "react";
import {
  View,
  Text,
  TextInput,
  Pressable,
  FlatList,
  ActivityIndicator,
  KeyboardAvoidingView,
  Platform,
} from "react-native";
import { Audio } from "expo-av";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { useAuth } from "@/contexts/auth-context";

import { aiService } from "@/services/ai-service";
import { IconSymbol } from "@/components/ui/icon-symbol";

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
  const [inputHeight, setInputHeight] = useState(40);
  const [messages, setMessages] = useState<Message[]>([]);
  const [loading, setLoading] = useState(false);

  /* ======================================================
      VOICE RECORDING
  ====================================================== */

  const [recording, setRecording] = useState<Audio.Recording | null>(null);
  const [isRecording, setIsRecording] = useState(false);

  const startRecording = async () => {
    try {
      const perm = await Audio.requestPermissionsAsync();
      if (!perm.granted) return;

      await Audio.setAudioModeAsync({
        allowsRecordingIOS: true,
        playsInSilentModeIOS: true,
      });

      const rec = new Audio.Recording();
      await rec.prepareToRecordAsync({
        android: {
          extension: ".m4a",
          outputFormat: Audio.AndroidOutputFormat.MPEG_4,
          audioEncoder: Audio.AndroidAudioEncoder.AAC,
          sampleRate: 44100,
          numberOfChannels: 1,
          bitRate: 128000,
        },
        ios: {
          extension: ".m4a",
          audioQuality: Audio.IOSAudioQuality.MAX,
          sampleRate: 44100,
          numberOfChannels: 1,
          bitRate: 128000,
        },
        web: {
          mimeType: "audio/webm",
          bitsPerSecond: 128000,
        },
      });

      await rec.startAsync();
      setRecording(rec);
      setIsRecording(true);
    } catch (err) {
      console.error("Recording start error", err);
    }
  };

  const stopRecording = async () => {
    if (!recording) return;

    try {
      setIsRecording(false);
      await recording.stopAndUnloadAsync();
      const fileUri = recording.getURI();
      setRecording(null);

      if (fileUri) {
        await transcribeVoice(fileUri);
      }
    } catch (err) {
      console.error("Recording stop error", err);
    }
  };

  /* ======================================================
      TRANSCRIBE VOICE → FILL INPUT BOX
  ====================================================== */

  const transcribeVoice = async (fileUri: string) => {
    if (!user?.id) return;

    setLoading(true);

    try {
      const response = await aiService.voiceChat(user.id, fileUri);
      const transcript = response.voice_text?.trim() || "";

      // 1️⃣ Show transcription in textbox (editable)
      setInput(transcript);

      // 2️⃣ Show what user spoke in chat
      setMessages((prev) => [
        ...prev,
        { role: "user", text: transcript || "(No speech detected)" },
      ]);

      // 3️⃣ Auto-send only if meaningful
      if (transcript.length > 2) {
        const aiResp = await aiService.chat(user.id, transcript);
        setMessages((prev) => [
          ...prev,
          { role: "assistant", text: aiResp.answer || "No response." },
        ]);
      } else {
        setMessages((prev) => [
          ...prev,
          {
            role: "assistant",
            text: "I couldn't understand that. Please try speaking again.",
          },
        ]);
      }
    } catch (err) {
      console.error("Voice transcription error:", err);
      setMessages((prev) => [
        ...prev,
        { role: "assistant", text: "Voice processing failed. Please retry." },
      ]);
    } finally {
      setLoading(false);
    }
  };

  /* ======================================================
      SEND TEXT MESSAGE
  ====================================================== */

  const sendMessage = async (text?: string) => {
    if (!user?.id || loading) return;

    const question = (text ?? input).trim();
    if (!question) return;

    setMessages((prev) => [...prev, { role: "user", text: question }]);
    setInput("");
    setInputHeight(40);
    setLoading(true);

    try {
      const res = await aiService.chat(user.id, question);
      setMessages((prev) => [
        ...prev,
        { role: "assistant", text: res?.answer || "No response." },
      ]);
    } catch (err) {
      console.error("AI error", err);
      setMessages((prev) => [
        ...prev,
        { role: "assistant", text: "AI unavailable. Try again." },
      ]);
    } finally {
      setLoading(false);
    }
  };

  /* ======================================================
      CLEAR
  ====================================================== */

  const clearChat = () => {
    setMessages([]);
    setInput("");
    setInputHeight(40);
    setRecording(null);
    setIsRecording(false);
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === "ios" ? "padding" : "height"}
      keyboardVerticalOffset={90}
    >
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
          <Text style={{ color: COLORS.textSecondary, fontSize: 13, fontWeight: "600" }}>
            AI Assistant
          </Text>

          {!!messages.length && (
            <Pressable onPress={clearChat}>
              <Text style={{ color: COLORS.danger, fontSize: 13 }}>Clear</Text>
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
                alignSelf: item.role === "user" ? "flex-end" : "flex-start",
                maxWidth: "85%",
              }}
            >
              <Text
                style={{
                  backgroundColor:
                    item.role === "user" ? COLORS.primary : COLORS.surface,
                  color:
                    item.role === "user" ? COLORS.textInverse : COLORS.text,
                  paddingHorizontal: 12,
                  paddingVertical: 8,
                  borderRadius: 12,
                  marginVertical: 4,
                }}
              >
                {item.text}
              </Text>
            </View>
          )}
        />

        {loading && (
          <ActivityIndicator
            size="small"
            color={COLORS.primary}
            style={{ paddingVertical: 4 }}
          />
        )}

        {/* ================= FAQ ================= */}

        <View style={{ marginVertical: 6 }}>
          <Text style={{ color: COLORS.textSecondary, marginBottom: 6, fontSize: 12 }}>
            Try asking:
          </Text>

          <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
            {AI_FAQ.map((item) => (
              <Pressable
                key={item}
                onPress={() => setInput(item)}
                style={styles.chip}
              >
                <Text style={styles.chipText}>{item}</Text>
              </Pressable>
            ))}
          </View>
        </View>

        {/* ================= INPUT BAR ================= */}

        <View
          style={{
            flexDirection: "row",
            alignItems: "flex-end",
            gap: 8,
            marginTop: 6,
          }}
        >
          <TextInput
            value={input}
            onChangeText={setInput}
            placeholder="Ask about your spending..."
            placeholderTextColor={COLORS.textMuted}
            multiline
            style={[
              styles.textInput,
              {
                flex: 1,
                height: Math.min(120, inputHeight),
                textAlignVertical: "top",
              },
            ]}
            onContentSizeChange={(e) =>
              setInputHeight(e.nativeEvent.contentSize.height)
            }
          />

          {/* MIC BUTTON */}
          <Pressable
            onPress={isRecording ? stopRecording : startRecording}
            style={{
              backgroundColor: isRecording ? COLORS.danger : COLORS.primary,
              width: 50,
              height: 50,
              borderRadius: 25, 
              justifyContent: "center",
              alignItems: "center",
              marginBottom: 5
            }}
          >
            {isRecording ? (
              <Text style={[styles.buttonText, { fontSize: 12, marginBottom: 4 }]}>Stop</Text>
            ) : (
              <IconSymbol name="mic.fill" size={20} color={COLORS.textInverse} />
            )}
          </Pressable>

          {/* SEND BUTTON */}
          <Pressable
            onPress={() => sendMessage()}
            disabled={loading}
            style={[
              styles.button,
              { paddingHorizontal: 14, paddingVertical: 10 },
              loading && { opacity: 0.6 },
            ]}
          >
            <Text style={styles.buttonText}>
              {loading ? "..." : "Send"}
            </Text>
          </Pressable>
        </View>

        {/* RECORDING STATUS */}
        {isRecording && (
          <Text style={{ color: COLORS.warning, marginTop: 4 }}>
            🎙️ Listening...
          </Text>
        )}
      </View>
    </KeyboardAvoidingView>
  );
}
