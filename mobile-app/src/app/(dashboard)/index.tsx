import Header from '@/src/components/header';
import styles from '@/src/styles/styles'
import { useRouter } from 'expo-router';
import React from 'react'
import { Button, Pressable, Text, View } from 'react-native'
import { SafeAreaView } from 'react-native-safe-area-context';

export default function Dashboard() {
	const router = useRouter();
	const gotoTransactions = () => {
		router.replace("/(transaction)");
	}
	const gotoBudgets = () => {
		router.replace("/(budget)");
	}
	return (
		<View style={styles.content}>
			<Header title='Dashboard' />
			<View style={styles.container}>
				<Text style={styles.title}>This is a Dashboard</Text>
				<Pressable style={styles.button} onPress={gotoTransactions}>
					<Text>Transactions</Text>
				</Pressable>
				<Pressable style={styles.button} onPress={gotoBudgets}>
					<Text>Budgets</Text>
				</Pressable>
			</View>
		</View>
	)
}
