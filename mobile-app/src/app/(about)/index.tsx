// mobile-app/src/app/(about)/index.tsx

import { View, Text, ScrollView } from "react-native";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

const About = () => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ single theme source

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
      <View style={styles.container}>

        {/* ================= APP NAME ================= */}

        <Text
          style={[
            styles.welcome,
            { color: COLORS.primary }
          ]}
        >
          🌟 ExpenseApp
        </Text>

        {/* ================= DESCRIPTION ================= */}

        <Text
          style={[
            styles.text,
            {
              color: COLORS.text,
              lineHeight: 22,
              marginBottom: 16,
            },
          ]}
        >
          ExpenseApp is a smart, AI-powered expense tracking application designed
          to help users manage their finances with clarity, control, and confidence.
          Built with a modular architecture and a focus on user experience,
          it offers intuitive tools for tracking, analyzing, forecasting,
          and optimizing daily spending.
        </Text>

        {/* ================= FEATURES ================= */}

        <Text
          style={[
            styles.title,
            {
              color: COLORS.text,
              marginBottom: 6,
            },
          ]}
        >
          🚀 Features
        </Text>

        {[
          "Track Daily Expenses",
          "Analyze Spending Patterns",
          "Forecast Future Expenses",
          "Suggest Expense Controls",
          "AI Assistance via LangChain + Ollama",
          "Secure Authentication & Data Storage",
          "Modular Navigation with Drawer + Tabs",
          "Onboarding Flow with Splash + Intro Screens",
        ].map((feature) => (
          <Text
            key={feature}
            style={{
              fontSize: 16,
              color: COLORS.textSecondary,
              marginBottom: 6,
            }}
          >
            • {feature}
          </Text>
        ))}

        {/* ================= TECH STACK ================= */}

        <Text
          style={[
            styles.title,
            {
              color: COLORS.text,
              marginTop: 16,
              marginBottom: 6,
            },
          ]}
        >
          🧱 Tech Stack
        </Text>

        <Text
          style={{
            fontSize: 16,
            fontWeight: "600",
            color: COLORS.text,
          }}
        >
          Frontend:
        </Text>

        <Text
          style={{
            fontSize: 16,
            color: COLORS.textSecondary,
            lineHeight: 22,
            marginBottom: 10,
          }}
        >
          - React Native (TypeScript)
          {"\n"}- Expo
          {"\n"}- Redux
          {"\n"}- React Navigation (Drawer + Tabs)
          {"\n"}- LangChain + Ollama (AI Assistant)
        </Text>

        <Text
          style={{
            fontSize: 16,
            fontWeight: "600",
            color: COLORS.text,
          }}
        >
          Backend:
        </Text>

        <Text
          style={{
            fontSize: 16,
            color: COLORS.textSecondary,
            lineHeight: 22,
            marginBottom: 10,
          }}
        >
          - FastAPI
          {"\n"}- PostgreSQL
        </Text>

        {/* ================= SECURITY ================= */}

        <Text
          style={[
            styles.title,
            {
              color: COLORS.text,
              marginTop: 12,
              marginBottom: 6,
            },
          ]}
        >
          🔐 Security
        </Text>

        {[
          "Secure storage for sensitive data",
          "Encrypted API communication",
          "Logout and session management via AuthContext",
        ].map((item) => (
          <Text
            key={item}
            style={{
              fontSize: 16,
              color: COLORS.textSecondary,
              marginBottom: 6,
            }}
          >
            • {item}
          </Text>
        ))}

        {/* ================= AI ASSISTANT ================= */}

        <Text
          style={[
            styles.title,
            {
              color: COLORS.text,
              marginTop: 12,
              marginBottom: 6,
            },
          ]}
        >
          🧠 AI Assistant
        </Text>

        <Text
          style={{
            fontSize: 16,
            color: COLORS.textSecondary,
            lineHeight: 22,
            marginBottom: 6,
          }}
        >
          ExpenseApp integrates LangChain + Ollama to provide contextual AI support:
          {"\n"}- Code generation from natural language
          {"\n"}- Budgeting suggestions
          {"\n"}- Forecasting logic
          {"\n"}- Minimal, focused responses
        </Text>

        {/* ================= FOOTER ================= */}

        <View style={{ marginTop: 30 }}>
          <Text
            style={{
              fontSize: 14,
              textAlign: "center",
              color: COLORS.textMuted,
            }}
          >
            Version 1.0 • Built with ❤️ by ExpenseApp Team
          </Text>
        </View>

      </View>
    </ScrollView>
  );
};

export default About;
