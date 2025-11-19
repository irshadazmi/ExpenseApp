// src/components/AppHeader.tsx
import { View, Text, StyleSheet } from 'react-native';
import { COLORS } from '../constants/COLORS';

const AppHeader = ({ title }: { title: string }) => (
  <View style={headerStyles.container}>
    <Text style={headerStyles.text}>{title}</Text>
  </View>
);

const headerStyles = StyleSheet.create({
  container: {
    width: '100%',
    height: 56,
    backgroundColor: COLORS.primary,
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 5,
    shadowColor: COLORS.cardShadow,
    shadowOpacity: 0.15,
    shadowOffset: { width: 0, height: 2 },
    shadowRadius: 6,
  },
  text: {
    color: COLORS.white,
    fontSize: 20,
    fontWeight: '700',
    letterSpacing: 1,
  },
});

export default AppHeader;
