import React from 'react'
import { Pressable, Text, View } from 'react-native'
import styles from '../styles/styles'
import { useRouter } from 'expo-router'
import { IconSymbol } from './ui/icon-symbol';

type HeaderProps = {
  title: string
}

export default function Header({ title }: HeaderProps) {
  const router = useRouter();

  const logout = () => {
    router.replace("/login");
  };

  return (
    <View style={styles.header}>
      {/* App Title */}
      <Text style={styles.headerTitle}>
        {title}
      </Text>

      {/* Logout Icon */}
      <Pressable onPress={logout}>
        <IconSymbol
          name="rectangle.portrait.and.arrow.right"
          size={26}
          color="#fff"
        />
      </Pressable>
    </View>
  )
}