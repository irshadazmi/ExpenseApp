// mobile-app/src/app/(help)/index.tsx

import { View, Text, ScrollView, Pressable, Linking } from "react-native";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

const Help = () => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ single source of truth

  return (
    <ScrollView
      style={{
        flex: 1,
        backgroundColor: COLORS.background,
      }}
      contentContainerStyle={{
        padding: 20,
        paddingBottom: 40,
      }}
    >
      {/* ==================== TITLE ==================== */}

      <Text
        style={[
          styles.title,
          {
            fontSize: 24,
            color: COLORS.primary,
            marginBottom: 12,
          },
        ]}
      >
        🆘 Help & Support
      </Text>

      {/* ==================== INTRO ==================== */}

      <Text
        style={[
          styles.text,
          {
            lineHeight: 22,
            marginBottom: 20,
          },
        ]}
      >
        Need assistance using ExpenseApp? We're here to help. Below are answers
        to common questions and ways to get support.
      </Text>

      {/* ==================== FAQ ==================== */}

      <Text
        style={[
          styles.title,
          {
            fontSize: 18,
            color: COLORS.text,
            marginBottom: 12,
          },
        ]}
      >
        📋 Frequently Asked
      </Text>

      {[
        {
          q: "How do I log an expense?",
          a: 'Go to the Dashboard tab and tap the "+" icon to add a new expense. You can categorize and add notes.',
        },
        {
          q: "Can I edit or delete an expense?",
          a: "Yes. Tap on any expense entry to view, edit, or delete it.",
        },
        {
          q: "How does forecasting work?",
          a: "Forecasting uses your past spending patterns to predict future expenses. You’ll find it under the Analytics tab.",
        },
        {
          q: "Is my data secure?",
          a: "Absolutely. We use encrypted storage and secure APIs to protect your data.",
        },
        {
          q: "How do I contact support?",
          a: "Use the Feedback page to report issues or suggestions, or email us directly.",
        },
      ].map(({ q, a }) => (
        <View
          key={q}
          style={{
            backgroundColor: COLORS.card,
            borderRadius: 10,
            padding: 12,
            marginBottom: 12,

            // ✅ shadow safe across themes
            shadowColor: COLORS.cardShadow,
            shadowOpacity: 0.12,
            shadowRadius: 4,
            shadowOffset: { width: 0, height: 1 },
            elevation: 2,
          }}
        >
          <Text
            style={{
              fontSize: 16,
              fontWeight: "600",
              color: COLORS.text,
              marginBottom: 4,
            }}
          >
            {q}
          </Text>

          <Text
            style={{
              fontSize: 15,
              lineHeight: 20,
              color: COLORS.textSecondary,
            }}
          >
            {a}
          </Text>
        </View>
      ))}

      {/* ==================== CONTACT ==================== */}

      <Text
        style={[
          styles.title,
          {
            fontSize: 18,
            marginTop: 20,
            marginBottom: 10,
          },
        ]}
      >
        📬 Contact Us
      </Text>

      <Text
        style={[
          styles.text,
          {
            marginBottom: 12,
          },
        ]}
      >
        For technical issues, feature requests, or general questions, reach out
        to us:
      </Text>

      <Pressable onPress={() => Linking.openURL("mailto:support@expenseapp.ai")}>
        <Text
          style={{
            fontSize: 16,
            color: COLORS.primary,
            textDecorationLine: "underline",
            marginBottom: 24,
          }}
        >
          support@expenseapp.ai
        </Text>
      </Pressable>

      {/* ==================== FOOTER ==================== */}

      <Text
        style={{
          fontSize: 13,
          color: COLORS.textMuted,
          textAlign: "center",
          marginTop: 8,
        }}
      >
        Version 1.0 • Last updated Nov 2025
      </Text>
    </ScrollView>
  );
};

export default Help;
