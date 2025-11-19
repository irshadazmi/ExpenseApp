// src/components/BottomTabBar.tsx
import React from 'react';
import { BottomTabBarProps } from '@react-navigation/bottom-tabs';
import { View, TouchableOpacity, Text, StyleSheet } from 'react-native';
import { COLORS } from '../constants/COLORS';

const BottomTabBar = ({ state, descriptors, navigation }: BottomTabBarProps) => (
	<View style={tabBarStyles.container}>
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
						tabBarStyles.tab,
						isFocused && { borderTopColor: COLORS.white, borderTopWidth: 4 }
					]}
				>
					<Text style={[tabBarStyles.text, isFocused && { color: COLORS.primary }]}>
						{typeof label === 'string' ? label : ''}
					</Text>
				</TouchableOpacity>
			);
		})}
	</View>
);

const tabBarStyles = StyleSheet.create({
	container: {
		flexDirection: 'row',
		height: 56,
		backgroundColor: COLORS.primary,
		borderTopLeftRadius: 10,
		borderTopRightRadius: 10,
		shadowColor: COLORS.cardShadow,
		shadowOpacity: 0.07,
		shadowOffset: { width: 0, height: -2 },
		shadowRadius: 6,
		elevation: 8,
	},
	tab: {
		flex: 1,
		justifyContent: 'center',
		alignItems: 'center',
	},
	text: {
		color: COLORS.white,
		fontWeight: '600',
		fontSize: 14,
		letterSpacing: 0.5,
	}
});

export default BottomTabBar;
