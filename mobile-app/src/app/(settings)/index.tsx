// mobile-app/src/app/(settings)/index.tsx

import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  ScrollView,
  Pressable,
  Alert,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import { CURRENCIES } from "@/constants/CONSTANTS";
import { settingsService } from "@/services/settings-service";
import { AppSettings } from "@/types/settings";
import { RelativePathString, useRouter } from "expo-router";
import { useTheme } from "@/contexts/theme-context";

/* ======================================================
    CONSTANTS
====================================================== */

const DATE_FORMATS = ["DD-MM-YYYY", "MM-DD-YYYY"] as const;
const PERIODS = ["Monthly", "Quarterly", "Yearly"] as const;
const THEMES = ["System", "Light", "Dark"] as const;

/* ======================================================
    COMPONENT
====================================================== */

const Settings = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const { setMode } = useTheme();

  const [settings, setSettings] = useState<AppSettings>({
    currency: "INR",
    dateFormat: "DD-MM-YYYY",
    dashboardPeriod: "Monthly",
    budgetAlerts: true,

    // ✅ default matches backend contract
    theme: "System",
  });

  const [loading, setLoading] = useState(true);

  /* ======================================================
      LOAD SETTINGS
  ====================================================== */

  useEffect(() => {
    (async () => {
      try {
        const prefs = await settingsService.get();
        setSettings(prefs);
      } catch {
        Alert.alert("Error", "Failed to load settings.");
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  /* ======================================================
      SAVE SETTINGS
  ====================================================== */

  const update = async <K extends keyof AppSettings>(
    key: K,
    value: AppSettings[K]
  ) => {
    const next = {
      ...settings,
      [key]: value,
    };

    setSettings(next);
    await settingsService.save(next);

    // ✅ Sync theme immediately
    if (key === "theme") {
      const mapped =
        value === "System"
          ? "system"
          : value === "Light"
          ? "light"
          : "dark";

      await setMode(mapped);
    }
  };

  /* ======================================================
      CHIP UI
  ====================================================== */

  const renderChips = (
    title: string,
    options: readonly string[],
    selected: string,
    onSelect: (val: string) => void
  ) => (
    <View style={styles.card}>
      <Text style={styles.label}>{title}</Text>

      <View style={[styles.chipsContainer, { flexWrap: "wrap" }]}>
        {options.map((opt) => {
          const active = selected === opt;

          return (
            <Pressable
              key={opt}
              style={[
                styles.chip,
                active && styles.chipSelected,
              ]}
              onPress={() => onSelect(opt)}
            >
              <Text
                style={[
                  styles.chipText,
                  active &&
                    styles.chipTextSelected,
                ]}
              >
                {opt}
              </Text>
            </Pressable>
          );
        })}
      </View>
    </View>
  );

  /* ======================================================
      RENDER
  ====================================================== */

  if (loading) return null;

  return (
    <View style={[styles.container, { paddingHorizontal: 16 }]}>
      {/* ================= HEADER ================= */}

      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          marginBottom: 16,
        }}
      >
        <Text
          style={[
            styles.title,
            { flex: 1, textAlign: "left", marginBottom: 0 },
          ]}
        >
          Settings
        </Text>
      </View>

      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ paddingBottom: 24 }}
      >
        {/* ================= PREFERENCES ================= */}

        <Text style={styles.sectionLabel}>Preferences</Text>

        {/* ✅ THEME PICKER */}
        {renderChips(
          "App Theme",
          THEMES,
          settings.theme,
          (v) => update("theme", v as AppSettings["theme"])
        )}

        {renderChips(
          "Default Currency",
          CURRENCIES,
          settings.currency,
          (v) => update("currency", v)
        )}

        {renderChips(
          "Date Format",
          DATE_FORMATS as unknown as string[],
          settings.dateFormat,
          (v) =>
            update(
              "dateFormat",
              v as AppSettings["dateFormat"]
            )
        )}

        {renderChips(
          "Dashboard Period",
          PERIODS as unknown as string[],
          settings.dashboardPeriod,
          (v) =>
            update(
              "dashboardPeriod",
              v as AppSettings["dashboardPeriod"]
            )
        )}

        {/* ================= BUDGET ALERT ================= */}

        <View style={styles.card}>
          <View style={styles.metaRow}>
            <Text style={styles.cardTitle}>
              Budget Alerts
            </Text>

            <Pressable
              onPress={() =>
                update(
                  "budgetAlerts",
                  !settings.budgetAlerts
                )
              }
            >
              <View
                style={{
                  width: 26,
                  height: 26,
                  borderRadius: 13,
                  borderWidth: 2,
                  borderColor: COLORS.primary,
                  backgroundColor: settings.budgetAlerts
                    ? COLORS.primary
                    : "transparent",
                }}
              />
            </Pressable>
          </View>
        </View>

        {/* ================= ACCOUNT ================= */}

        <Text style={styles.sectionLabel}>Account</Text>

        <Pressable
          style={styles.card}
          onPress={() =>
            router.push(
              "/profile" as RelativePathString
            )
          }
        >
          <Text style={styles.cardTitle}>
            Profile
          </Text>
          <Text style={styles.metaText}>
            Update your personal information
          </Text>
        </Pressable>

        <Pressable
          style={styles.card}
          onPress={() =>
            router.push(
              "/change-password" as RelativePathString
            )
          }
        >
          <Text style={styles.cardTitle}>
            Change Password
          </Text>
          <Text style={styles.metaText}>
            Update your account password
          </Text>
        </Pressable>
      </ScrollView>
    </View>
  );
};

export default Settings;
