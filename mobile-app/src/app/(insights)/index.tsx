// mobile-app/src/app/(insights)/index.tsx
import { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  ActivityIndicator,
} from "react-native";

import { useAuth } from "@/contexts/auth-context";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { aiService } from "@/services/ai-service";

import type { AIInsight } from "@/types/ai";

/* ======================================================
    COMPONENT
====================================================== */

export default function AiInsights() {
  const styles = useStyles();
  const COLORS = useAppColors();
  const { user } = useAuth();

  const [insights, setInsights] = useState<AIInsight[]>([]);
  const [loading, setLoading] = useState(false);

  /* ======================================================
      LOAD INSIGHTS
  ====================================================== */

  const loadInsights = async () => {
    if (!user?.id) return;

    setLoading(true);

    try {
      const res = await aiService.getInsights(user.id);
      setInsights(res);   // ✅ correct
    } catch (err) {
      console.error("Failed to load insights", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!user?.id) return;

    loadInsights();
  }, [user?.id]);

  /* ======================================================
      SEVERITY COLORS
  ====================================================== */

  const getSeverityColor = (
    severity: AIInsight["severity"]
  ) => {
    switch (severity) {
      case "HIGH":
        return COLORS.danger;
      case "MEDIUM":
        return COLORS.warning;
      case "LOW":
      default:
        return COLORS.success;
    }
  };

  /* ======================================================
      EMPTY STATE
  ====================================================== */

  if (insights.length === 0) {
    return (
      <View style={styles.formContainer}>
        <Text
          style={{
            textAlign: "center",
            color: COLORS.textMuted,
          }}
        >
          No insights available right now.
        </Text>
      </View>
    );
  }

  /* ======================================================
      RENDER
  ====================================================== */

  return (
    <View style={styles.formContainer}>
      <Text style={styles.title}>
        AI Insights
      </Text>

      {loading ? (
        <ActivityIndicator
          size="small"
          color={COLORS.primary}
        />
      ) : (
        <FlatList
          data={insights}
          keyExtractor={(_, i) =>
            `insight-${i}`
          }
          showsVerticalScrollIndicator={false}
          contentContainerStyle={{
            paddingTop: 10,
            paddingBottom: 20,
          }}
          renderItem={({ item }) => (
            <View
              style={{
                backgroundColor: COLORS.surface,
                padding: 14,
                borderRadius: 12,
                marginBottom: 10,
                borderLeftWidth: 5,
                borderLeftColor: getSeverityColor(item.severity),
                shadowColor: COLORS.cardShadow,
                shadowOpacity: 0.07,
                shadowOffset: { width: 0, height: 2 },
                shadowRadius: 3,
                elevation: 1,
              }}
            >
              {/* ---------- TITLE + TYPE BADGE ---------- */}
              <View
                style={{
                  flexDirection: "row",
                  alignItems: "center",
                  justifyContent: "space-between",
                }}
              >
                <Text
                  style={{
                    fontSize: 14,
                    fontWeight: "700",
                    color: COLORS.text,
                    flex: 1,
                  }}
                >
                  {item.title}
                </Text>

                {item.insight_type && (
                  <View
                    style={{
                      marginLeft: 8,
                      paddingHorizontal: 8,
                      paddingVertical: 2,
                      borderRadius: 6,
                      backgroundColor: COLORS.divider,
                    }}
                  >
                    <Text
                      style={{
                        fontSize: 10,
                        fontWeight: "700",
                        color: COLORS.textSecondary,
                      }}
                    >
                      {item.insight_type}
                    </Text>
                  </View>
                )}
              </View>

              {/* ---------- MESSAGE ---------- */}
              <Text
                style={{
                  color: COLORS.textSecondary,
                  marginVertical: 6,
                }}
              >
                {item.message}
              </Text>

              {/* ---------- WHY (EXPLAINABILITY) ---------- */}
              {item.metadata?.why && (
                <Text
                  style={{
                    fontSize: 11,
                    color: COLORS.textMuted,
                    fontStyle: "italic",
                    marginBottom: 6,
                  }}
                >
                  Why: {item.metadata.why}
                </Text>
              )}

              {/* ---------- FOOTER ROW ---------- */}
              <View
                style={{
                  flexDirection: "row",
                  justifyContent: "space-between",
                  alignItems: "center",
                }}
              >
                <Text
                  style={{
                    fontSize: 11,
                    fontWeight: "700",
                    letterSpacing: 0.5,
                    color: getSeverityColor(item.severity),
                    textTransform: "uppercase",
                  }}
                >
                  {item.severity} severity
                </Text>

                {typeof item.confidence === "number" && (
                  <Text
                    style={{
                      fontSize: 10,
                      color: COLORS.textMuted,
                    }}
                  >
                    Confidence: {(item.confidence * 100).toFixed(0)}%
                  </Text>
                )}
              </View>
            </View>
          )}
        />
      )}
    </View>
  );
}
