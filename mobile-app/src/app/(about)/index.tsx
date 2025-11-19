import { View, Text, ScrollView } from "react-native";
import React from "react";
import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";

const About = () => {
	return (
    <ScrollView style={{ flex: 1, backgroundColor: COLORS.white, padding: 20 }}>
      {/* App Name */}
      <Text style={{ fontSize: 24, fontWeight: '700', color: COLORS.primary, marginBottom: 12 }}>
        🌟 ExpenseApp
      </Text>

      {/* Description */}
      <Text style={{ fontSize: 16, color: COLORS.text, marginBottom: 20 }}>
        ExpenseApp is a smart, AI-powered expense tracking application designed to help users manage
        their finances with clarity, control, and confidence. Built with a modular architecture and
        a focus on user experience, it offers intuitive tools for tracking, analyzing, forecasting,
        and optimizing daily spending.
      </Text>

      {/* Features */}
      <Text style={{ fontSize: 18, fontWeight: '600', marginBottom: 8 }}>🚀 Features</Text>
      {[
        'Track Daily Expenses',
        'Analyze Spending Patterns',
        'Forecast Future Expenses',
        'Suggest Expense Controls',
        'AI Assistance via LangChain + Ollama',
        'Secure Authentication & Data Storage',
        'Modular Navigation with Drawer + Tabs',
        'Onboarding Flow with Splash + Intro Screens',
      ].map((feature) => (
        <Text key={feature} style={{ fontSize: 16, marginBottom: 6 }}>
          • {feature}
        </Text>
      ))}

      {/* Tech Stack */}
      <Text style={{ fontSize: 18, fontWeight: '600', marginTop: 20, marginBottom: 8 }}>
        🧱 Tech Stack
      </Text>
      <Text style={{ fontSize: 16, fontWeight: '600' }}>Frontend:</Text>
      <Text style={{ fontSize: 16, marginBottom: 6 }}>
        - React Native (TypeScript)
        {'\n'}- Expo
        {'\n'}- Redux
        {'\n'}- React Navigation (Drawer + Tabs)
        {'\n'}- LangChain + Ollama (AI Assistant)
      </Text>
      <Text style={{ fontSize: 16, fontWeight: '600' }}>Backend:</Text>
      <Text style={{ fontSize: 16, marginBottom: 6 }}>
        - FastAPI
        {'\n'}- PostgreSQL
      </Text>

      {/* Security */}
      <Text style={{ fontSize: 18, fontWeight: '600', marginTop: 20, marginBottom: 8 }}>
        🔐 Security
      </Text>
      {[
        'Secure storage for sensitive data',
        'Encrypted API communication',
        'Logout and session management via AuthContext',
      ].map((item) => (
        <Text key={item} style={{ fontSize: 16, marginBottom: 6 }}>
          • {item}
        </Text>
      ))}

      {/* AI Assistant */}
      <Text style={{ fontSize: 18, fontWeight: '600', marginTop: 20, marginBottom: 8 }}>
        🧠 AI Assistant
      </Text>
      <Text style={{ fontSize: 16, marginBottom: 6 }}>
        ExpenseApp integrates LangChain + Ollama to provide contextual AI support:
        {'\n'}- Code generation from natural language
        {'\n'}- Budgeting suggestions
        {'\n'}- Forecasting logic
        {'\n'}- Minimal, focused responses
      </Text>

      {/* Footer */}
      <View style={{ marginTop: 40 }}>
        <Text style={{ fontSize: 14, color: COLORS.text }}>
          Version 1.0 • Built with ❤️ by ExpenseApp Team
        </Text>
      </View>
    </ScrollView>
  );
};

export default About;