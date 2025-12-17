import app.schemas.ai_schema as AIInsight

class ExplanationEngine:
    def explain(self, insight: AIInsight) -> str:
        if insight.insight_type == "BUDGET_FORECAST":
            return (
                "This forecast is based on your spending pattern so far this month "
                "and assumes similar daily spending for the remaining days."
            )

        if insight.insight_type == "ANOMALY":
            return (
                "This insight was triggered because your spending is significantly "
                "higher than your usual average for this category."
            )

        if insight.insight_type == "BUDGET_STATUS":
            return (
                "This alert is based on a comparison between your actual spending "
                "and the budget you set for this category."
            )

        return "This insight is generated from your recent expense data."
