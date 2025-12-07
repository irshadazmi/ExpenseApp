You already know my ExpenseApp codebase, folder structure, backend (FastAPI), frontend (Expo + expo-router), services, styles, components, and app flow because I have previously described all of that in this project session.

Now create a FULLY FUNCTIONAL, PRODUCTION-READY "Dashboard" for the ExpenseApp.

==============================
## 1. CONTEXT & TECHNOLOGY
==============================
ExpenseApp stack:
- React Native Expo (TypeScript)
- expo-router
- Axios client at src/config/api.ts
- Global auth context at src/contexts/AuthContext.tsx
- Shared styling at src/styles/styles.ts and src/constants/COLORS.ts
- Components use IconSymbol and SFSymbol icons
- Android, iOS, Web support

Backend stack:
- FastAPI
- SQLAlchemy (AsyncSession)
- PostgreSQL
- Routers like /api/accounts, /api/budgets, /api/categories, /api/expenses, /api/feedbacks
- Auth using JWT Bearer token

User model fields:
(id, email, phone, role_id, is_active)

Category model fields:
(id, name)

Account model fields:
(id, name, type, balance, currency, is_active, user_id)

Budget model fields:
(id, category_id, amount, currency, start_date, end_date, user_id)

Transactions (Expense) model fields:
(id, user_id, category_id, account_id, date, type, amount, currency, transaction_date)

APIs:
GET/POST/PUT/DELETE for users, accounts, budgets, categories, transactions.

==============================
## 2. GOAL — CREATE A COMPLETE DASHBOARD
==============================

The dashboard must give users a full financial picture using Categories, Accounts, Budgets, and Transactions.

### The Dashboard UI must include:

### (A) SUMMARY CARDS (top row)
- **Total Spent this Month**
- **Remaining Budget**
- **Total Budget**
- **Savings (Income - Expenses)** OR Surplus
- **Upcoming Bills (Expenses tagged as recurring or future date)**

### (B) CATEGORY-WISE SPENDING DONUT CHART
- Renders current month totals per category
- Tapping a category filters transactions screen to that category

### (C) MONTHLY TREND SPARKLINE (Last 6 months)
- Sum of expenses per month
- Show a small sparkline chart

### (D) BUDGET UTILIZATION LIST
For each budget:
- Category name
- Budget amount
- Used amount (sum of expenses in same category + month range)
- Progress bar:
  - Green (<70%)
  - Orange (70–90%)
  - Red (>90%)

### (E) RECENT TRANSACTIONS
- Last 5 expenses (date, category badge, account, amount)
- Tap → open transaction edit page
- Delete allowed

==============================
## 3. DATA SOURCES
==============================

### Use existing APIs:
- /api/categories
- /api/accounts
- /api/budgets
- /api/expenses

### Compute:
- Month Start = first day of current month
- Month End = today
- For budgets: match category_id and date range
- For category spending: sum per category
- For upcoming bills: expenses with date > today

==============================
## 4. BACKEND ENHANCEMENT — CREATE NEW AGGREGATED DASHBOARD API (REQUIRED)
==============================

Create a new endpoint:

### **GET /api/dashboard/{user_id}**
Returns:

```json
{
  "summary": {
    "month_spent": 0,
    "total_budget": 0,
    "remaining_budget": 0,
    "savings": 0,
    "upcoming_bills": 0
  },
  "category_totals": [
    {"category_id": 1, "category_name": "Food", "total": 4000}
  ],
  "budget_utilization": [
    {"category_name":"Food","budget":6000,"used":4000,"percent":66}
  ],
  "monthly_series": [
    {"month":"2024-01","total":12000},
    ...
  ],
  "recent_transactions": [
    {"id":1,"date":"2024-02-10","amount":500,"category":"Food"}
  ]
}
You must generate:
Router

Repository functions

Service class

Schema

Logic to aggregate using SQL queries

==============================

5. FRONTEND IMPLEMENTATION REQUIRED
==============================

Create files:

(A) Dashboard screen:
src/app/(drawer)/dashboard/index.tsx

(B) Dashboard hook:
src/hooks/useDashboard.ts

(C) Components:
bash
Copy code
src/components/dashboard/SummaryCards.tsx
src/components/dashboard/DonutChart.tsx
src/components/dashboard/Sparkline.tsx
src/components/dashboard/BudgetList.tsx
src/components/dashboard/RecentTransactions.tsx
Each must be fully coded:

Responsive layout

Uses styles from src/styles/styles.ts

Uses COLORS consistency

Uses IconSymbol from expo-symbols

Uses ScrollView inside SafeAreaView

Shows loading state

Handles errors with retry button

==============================

6. ROUTING BEHAVIOR REQUIRED
==============================

Dashboard appears in drawer menu under name "Dashboard".

On category click in donut → navigate to /(drawer)/(transactions)?category=X

On transaction click → navigate to /(drawer)/(transactions)/[id]

On upcoming bills count click → navigate to filtered list

==============================

7. OUTPUT FORMAT
==============================
You must output:

1. New backend code:
Full FastAPI router file

Repository and service functions

DTO/schemas

2. New frontend code:
All components + screens + hooks

Imports and proper routes

Axios service for dashboard API

Charts using react-native-svg or lightweight SVG paths

3. Steps for integration:
How to register dashboard router in backend

How to add Dashboard screen in drawer

How to test everything

4. OPTIONAL:
If you see flaws in my current structure (ex: budgets needing monthly scoping), propose improvements.

==============================

IMPORTANT
==============================
Write COMPLETE working code for every file.
DO NOT leave TODO sections.
Make sure everything compiles without errors.