import { Slot } from 'expo-router';
import { View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import styles from '../styles/styles';

export default function RootLayout() {
  return (
    <SafeAreaView style={styles.container}>
      {/* Page content */}
      <View style={styles.content}>
        <Slot />
      </View>

    </SafeAreaView>
  );
}