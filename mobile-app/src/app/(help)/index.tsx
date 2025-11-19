import { View, Text, ScrollView, Pressable, Linking } from "react-native";
import { COLORS } from "@/constants/COLORS";

const Help = () => {
	return (
    <ScrollView style={{ flex: 1, backgroundColor: COLORS.white, padding: 20 }}>
      {/* Title */}
      <Text style={{ fontSize: 24, fontWeight: '700', color: COLORS.primary, marginBottom: 12 }}>
        🆘 Help & Support
      </Text>

      {/* Introduction */}
      <Text style={{ fontSize: 16, color: COLORS.text, marginBottom: 20 }}>
        Need assistance using ExpenseApp? We're here to help. Below are answers to common questions
        and ways to get support.
      </Text>

      {/* FAQ Section */}
      <Text style={{ fontSize: 18, fontWeight: '600', marginBottom: 8 }}>📋 Frequently Asked</Text>
      {[
        {
          q: 'How do I log an expense?',
          a: 'Go to the Dashboard tab and tap the "+" icon to add a new expense. You can categorize and add notes.',
        },
        {
          q: 'Can I edit or delete an expense?',
          a: 'Yes. Tap on any expense entry to view, edit, or delete it.',
        },
        {
          q: 'How does forecasting work?',
          a: 'Forecasting uses your past spending patterns to predict future expenses. You’ll find it under the Analytics tab.',
        },
        {
          q: 'Is my data secure?',
          a: 'Absolutely. We use encrypted storage and secure APIs to protect your data.',
        },
        {
          q: 'How do I contact support?',
          a: 'Use the Feedback page to report issues or suggestions, or email us directly.',
        },
      ].map(({ q, a }) => (
        <View key={q} style={{ marginBottom: 16 }}>
          <Text style={{ fontSize: 16, fontWeight: '600', marginBottom: 4 }}>{q}</Text>
          <Text style={{ fontSize: 16, color: COLORS.text }}>{a}</Text>
        </View>
      ))}

      {/* Contact Section */}
      <Text style={{ fontSize: 18, fontWeight: '600', marginTop: 20, marginBottom: 8 }}>
        📬 Contact Us
      </Text>
      <Text style={{ fontSize: 16, marginBottom: 12 }}>
        For technical issues, feature requests, or general questions, reach out to us:
      </Text>
      <Pressable
        onPress={() => Linking.openURL('mailto:support@expenseapp.ai')}
        style={{ marginBottom: 20 }}
      >
        <Text style={{ fontSize: 16, color: COLORS.primary, textDecorationLine: 'underline' }}>
          support@expenseapp.ai
        </Text>
      </Pressable>

      {/* Footer */}
      <Text style={{ fontSize: 14, color: COLORS.text }}>
        Version 1.0 • Last updated Nov 2025
      </Text>
    </ScrollView>
  );
};

export default Help;