// mobile-app/src/app/(dashboard)/components/year-month-selector.tsx
import React, { useRef } from "react";
import {
  View,
  ScrollView,
  Text,
  Animated,
  PanResponder,
  Pressable,
  GestureResponderEvent,
  PanResponderGestureState,
} from "react-native";
import * as Haptics from "expo-haptics";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { MONTHS } from "@/constants/MONTHS";

interface YearMonthSelectorProps {
  selectedYear: number;
  setSelectedYear: (year: number) => void;
  selectedMonthIndex: number;
  setSelectedMonthIndex: (index: number | ((prev: number) => number)) => void;
  currentYear: number;
}

export const YearMonthSelector: React.FC<YearMonthSelectorProps> = ({
  selectedYear,
  setSelectedYear,
  selectedMonthIndex,
  setSelectedMonthIndex,
  currentYear,
}) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const yearOptions = [
    currentYear - 4,
    currentYear - 3,
    currentYear - 2,
    currentYear - 1,
    currentYear,
  ];

  const quarterIndex = selectedMonthIndex === -1 ? -1 : Math.floor(selectedMonthIndex / 3);
  
  const visibleMonths = quarterIndex === -1 
    ? [] 
    : MONTHS.slice(quarterIndex * 3, quarterIndex * 3 + 3).map((m, i) => ({
        label: m,
        index: quarterIndex * 3 + i,
      }));

  const quarterAnim = useRef(new Animated.Value(1)).current;

  React.useEffect(() => {
    quarterAnim.setValue(0.9);
    Animated.spring(quarterAnim, {
      toValue: 1,
      friction: 5,
      tension: 45,
      useNativeDriver: true,
    }).start();
  }, [quarterIndex]);

  // ✅ Explicitly typing the PanResponder arguments
  const monthSwipe = useRef(
    PanResponder.create({
      onMoveShouldSetPanResponder: (
        _: GestureResponderEvent, 
        g: PanResponderGestureState
      ) => Math.abs(g.dx) > 20,
      onPanResponderRelease: (
        _: GestureResponderEvent, 
        g: PanResponderGestureState
      ) => {
        if (g.dx < -40) setSelectedMonthIndex((p: any) => Math.min((typeof p === 'function' ? p() : p) + 1, 11));
        if (g.dx > 40) setSelectedMonthIndex((p: any) => Math.max((typeof p === 'function' ? p() : p) - 1, 0));
      },
    })
  ).current;

  const AnimatedChip = ({
    label,
    active,
    onPress,
  }: {
    label: string | number;
    active: boolean;
    onPress: () => void;
  }) => {
    const scale = useRef(new Animated.Value(1)).current;

    const pressIn = () =>
      Animated.spring(scale, { toValue: 0.92, useNativeDriver: true }).start();

    const pressOut = async () => {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      Animated.spring(scale, {
        toValue: 1,
        friction: 3,
        tension: 40,
        useNativeDriver: true,
      }).start();
      onPress();
    };

    return (
      <Pressable onPressIn={pressIn} onPressOut={pressOut}>
        <Animated.View
          style={[
            styles.chip,
            active && styles.chipSelected,
            { transform: [{ scale }] },
          ]}
        >
          <Text style={[styles.chipText, active && styles.chipTextSelected]}>
            {label}
          </Text>
        </Animated.View>
      </Pressable>
    );
  };

  // ✅ Explicitly typing helper function parameters
  const renderSelectorRow = (
    label: string, 
    items: (string | number)[], 
    onPress: (item: any, idx: number) => void, 
    active: (item: any, idx: number) => boolean
  ) => (
    <View style={styles.chipsContainer} key={label}>
      <Text style={styles.chipLabel}>{label}</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        {items.map((v, vi) => (
          <AnimatedChip
            key={v.toString()}
            label={v}
            active={active(v, vi)}
            onPress={() => onPress(v, vi)}
          />
        ))}
      </ScrollView>
    </View>
  );

  return (
    <View>
      {renderSelectorRow(
        "Year:", 
        yearOptions, 
        (v: number) => setSelectedYear(v), 
        (v: number) => v === selectedYear
      )}

      {renderSelectorRow(
        "Quarter:", 
        ["Q1", "Q2", "Q3", "Q4"], 
        (_: string, idx: number) => setSelectedMonthIndex(idx * 3), 
        (_: string, idx: number) => quarterIndex === idx
      )}

      <View style={styles.chipsContainer}>
        <Text style={styles.chipLabel}>Month:</Text>
        <Animated.View
          style={{
            transform: [{ scale: quarterAnim }],
            opacity: quarterAnim,
          }}
        >
          <ScrollView 
            horizontal 
            showsHorizontalScrollIndicator={false}
            {...monthSwipe.panHandlers}
          >
            <AnimatedChip
              label="All"
              active={selectedMonthIndex === -1}
              onPress={() => setSelectedMonthIndex(-1)}
            />
            {visibleMonths.map((m) => (
              <AnimatedChip
                key={m.index}
                label={m.label}
                active={m.index === selectedMonthIndex}
                onPress={() => setSelectedMonthIndex(m.index)}
              />
            ))}
          </ScrollView>
        </Animated.View>
      </View>
    </View>
  );
};