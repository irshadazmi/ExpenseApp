import styles from '@/src/styles/styles'
import React from 'react'
import { Text, View } from 'react-native'

export default function Dashboard() {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>This is a Dashboard</Text>
		</View>
	)
}
