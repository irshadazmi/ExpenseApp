// src/components/AppHeader.tsx
import { View, Text } from 'react-native';
import styles from '@/styles/styles';

const AppHeader = ({ title }: { title: string }) => (
  <View style={styles.headerContainer}>
    <Text style={styles.headerText}>{title}</Text>
  </View>
);

export default AppHeader;
