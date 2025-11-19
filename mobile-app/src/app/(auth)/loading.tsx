// src/app/(auth)/loading.tsx
import { View, ActivityIndicator, Text, Image } from 'react-native';
import styles from '@/styles/styles';

const Loading = () => (
  <View style={[styles.container, { justifyContent: 'center', alignItems: 'center' }]}>
    {/* Optional: App logo at top */}
    <Image
      source={require('@/assets/images/expense-logo.png')} // Adjust the path if your logo is elsewhere
      style={{ width: 72, height: 72, marginBottom: 16 }}
      resizeMode="contain"
    />
    <ActivityIndicator size="large" color="#7F00FF" />
    <Text style={[styles.title, { marginTop: 18 }]}>Loading...</Text>
  </View>
);

export default Loading;