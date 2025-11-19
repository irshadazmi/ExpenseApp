🌟 ExpenseApp
ExpenseApp is a smart, AI-powered expense tracking application designed to help users manage their finances with clarity, control, and confidence. Built with a modular architecture and a focus on user experience, it offers intuitive tools for tracking, analyzing, forecasting, and optimizing daily spending.

🚀 Features
- Track Daily Expenses
Log and categorize your day-to-day spending with ease.
- Analyze Spending Patterns
Visual dashboards and summaries help you understand where your money goes.
- Forecast Future Expenses
Predict upcoming costs based on historical data and trends.
- Suggest Expense Controls
Receive actionable tips to reduce unnecessary spending.
- AI Assistance via LangChain + Ollama
Get intelligent, contextual help for budgeting, forecasting, and even code generation.
- Secure Authentication & Data Storage
User data is protected using secure storage and encrypted communication protocols.
- Modular Navigation with Drawer + Tabs
Seamless access to dashboards, accounts, analytics, reports, and settings.
- Onboarding Flow with Splash + Intro Screens
A visually engaging 5-screen onboarding experience introduces core features and benefits.

🧱 Tech Stack
Frontend:
- React Native (TypeScript)
- Expo
- Redux
- React Navigation (Drawer + Tabs)
- LangChain + Ollama (AI Assistant)
Backend:
- FastAPI
- PostgreSQL

📱 Onboarding Screens
- Splash Screen
Branded neon logo with dynamic visuals.
- Track Daily Expenses
Calendar, receipts, and intuitive logging.
- Analyze Spending
Charts and graphs for financial insights.
- Forecast Future Expenses
Predictive trends and budget planning.
- AI Assistance
Smart suggestions powered by LangChain/Ollama.
Each screen is styled with strong accent purples and tailored illustrations.

🔐 Security
- Secure storage for sensitive data
- Encrypted API communication
- Logout and session management via AuthContext

🧠 AI Assistant
ExpenseApp integrates LangChain + Ollama to provide contextual AI support:
- Code generation from natural language
- Budgeting suggestions
- Forecasting logic
- Minimal, focused responses

🗂️ Project Structure
mobile-app/
├── src/
│   ├── app/
│   │   ├── (auth)
│   │   ├── (drawer)
│   │   ├── (drawer)/tabs/
│   │   ├── intro/first_screen.tsx ... fourth_screen.tsx
│   │   ├── splash.tsx
│   │   ├── _layout.tsx
│   ├── assets/images/
│   ├── components/
│   ├── constants/
│   ├── contexts/
│   ├── hooks/
│   ├── styles/
│   └── tests/

backend-api/
├── app/
│   ├── core/
│   ├── database/
│   ├── models/
│   ├── repositories/
│   ├── routers/
│   ├── schemas/
│   ├── services/
│   ├── utils/
│   ├── app.py
│   └── main.py



