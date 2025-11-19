// src/components/BottomTabBar.tsx
import React from 'react';
import { BottomTabBarProps } from '@react-navigation/bottom-tabs';
import { View, TouchableOpacity, Text } from 'react-native';
import { COLORS } from '../constants/COLORS';
import styles from '@/styles/styles';

const BottomTabBar = ({ state, descriptors, navigation }: BottomTabBarProps) => (
	<View style={styles.tabBarContainer}>
		{state.routes.map((route, index) => {
			const { options } = descriptors[route.key];
			const label = options.tabBarLabel ?? options.title ?? route.name;
			const isFocused = state.index === index;

			const onPress = () => {
				if (!isFocused) {
					navigation.navigate(route.name as never);
				}
			};

			return (
				<TouchableOpacity
					key={route.key}
					accessibilityRole="button"
					accessibilityState={isFocused ? { selected: true } : {}}
					onPress={onPress}
					style={[
						styles.tabBarTab,
						isFocused && { borderTopColor: COLORS.white, borderTopWidth: 4 }
					]}
				>
					<Text style={[styles.tabBarText, isFocused && { color: COLORS.primary }]}>
						{typeof label === 'string' ? label : ''}
					</Text>
				</TouchableOpacity>
			);
		})}
	</View>
);

export default BottomTabBar;
