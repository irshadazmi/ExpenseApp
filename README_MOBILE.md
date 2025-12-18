# 📱 ExpenseApp Mobile Application

**React Native · Expo · TypeScript**

---

## 1. Overview

The **ExpenseApp mobile application** is built using **React Native**, **Expo**, and **TypeScript**, providing a fast, responsive, and maintainable user experience for:

* Expense & income tracking
* Budgeting and analytics
* AI-powered insights
* Conversational finance (text + voice)

The app is designed to work seamlessly with the **FastAPI backend** and **local AI engine**, following a **mobile-first, API-driven architecture**.

Navigation is handled using **Expo Router**, combining **Tabs + Drawer** layouts with **route-driven headers** (no manual title state management).

---

## 2. Project Structure

```
mobile-app/
 └─ src/
    ├─ app/             # Screens (Auth, Tabs, Drawer, CRUD, AI)
    ├─ assets/          # Images, icons, fonts
    ├─ components/      # Cards, Chips, Alerts, Charts
    ├─ config/          # Axios API configuration
    ├─ constants/       # DRAWER_ITEMS, TAB_ITEMS, months, labels
    ├─ contexts/        # AuthContext, ThemeContext
    ├─ hooks/           # useAppColors, voice helpers, utilities
    ├─ services/        # Backend API wrappers
    ├─ styles/          # Global theme & shared styles
    ├─ types/           # TypeScript models & DTOs
    └─ utils/           # Formatters, helpers, validators
```

---

## 3. Navigation Architecture

### Expo Router (File-Based Routing)

The app uses **Expo Router**, which maps files directly to navigation routes.

Navigation model:

* **Tabs**
  Primary navigation (Dashboard, Transactions, AI, etc.)

* **Drawer**
  Secondary and management screens (Categories, Budgets, Settings)

* **Header titles**
  Automatically derived from route metadata
  ✔ No manual state mutation
  ✔ No global header hacks

This results in predictable navigation and minimal boilerplate.

---

## 4. Core Screens & Features

### 4.1 Authentication

* Login
* Register
* Splash screen with automatic session restore via JWT
* Secure token storage via context

---

### 4.2 Dashboard

* Monthly expense & income charts
* Category-wise distribution
* Key financial KPIs
* Embedded **AI insights & alerts**
* Forecast overlays and severity indicators

---

### 4.3 Transactions

* Add / Edit / Delete transactions
* AI-assisted auto-categorization
* Optional **voice input** for descriptions
* Filters: **Year → Quarter → Month**

---

### 4.4 Categories

* Create, update, delete categories
* Active / inactive toggles
* Used across transactions, budgets, and AI insights

---

### 4.5 Budgets

* Category-based monthly budgets
* Visual budget health indicators
* AI-driven early warnings and overshoot detection

---

### 4.6 AI Chat & Voice Assistant

* Text-based AI chat
* Voice-based interaction using Whisper
* Natural-language finance queries

Examples:

* “How much did I spend on food last month?”
* “Which categories are over budget?”
* “Show last 5 transactions.”

---

## 5. State Management

The app uses **simple, predictable state management**:

* **AuthContext**

  * User profile
  * JWT token
  * Session restore logic

* **ThemeContext**

  * Light / Dark mode
  * Dynamic color resolution

* **Local component state**

  * Forms
  * Filters
  * UI interactions

No Redux or heavy global stores are used — intentionally.

---

## 6. Theming & Styling

* Light & Dark mode support
* Centralized color tokens
* Theme-aware components
* Styles resolved dynamically via context

This ensures consistent visuals across the app and easy theming changes.

---

## 7. API Integration

All backend communication is centralized in:

```
src/services/
```

Each domain has a dedicated service wrapper:

* `account-service.ts`
* `ai-service.ts`
* `budget-service.ts`
* `category-service.ts`
* `dashboard-service.ts`
* `feedbackai-service.ts`
* `settings-service.ts`
* `transaction-service.ts`

Benefits:

* Clean separation of concerns
* No API logic inside screens
* Easier mocking & testing

---

## 8. Runtime Configuration (Expo `app.json`)

ExpenseApp does **not** rely on `.env` files at runtime.
Instead, it uses **Expo’s `extra` configuration** in `app.json`.

### Example (`mobile-app/app.json`)

```json
{
  "expo": {
    "extra": {
      "API_BASE_URL": "http://192.168.29.62/api",
      "TOKEN_EXPIRY_MINUTES": 60
    }
  }
}
```

### Explanation

* **`API_BASE_URL`**
  Base URL of the backend API.
  All mobile API requests are built on top of this value.

  Typical values:

  * Emulator: `http://localhost/api`
  * Physical device (LAN): `http://<your-ip>/api`
  * Production: `https://api.yourdomain.com`

* **`TOKEN_EXPIRY_MINUTES`**
  Client-side token validity window before re-authentication or refresh logic is triggered.

### Accessing in code

```ts
import Constants from "expo-constants";

export const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL;

export const TOKEN_EXPIRY_MINUTES =
  Constants.expoConfig?.extra?.TOKEN_EXPIRY_MINUTES;
```

> ⚠️ After modifying `app.json`, **restart Expo** (`npx expo start`) for changes to take effect.

This approach:

* Avoids hardcoded URLs
* Supports dev / staging / prod environments
* Aligns with Expo best practices

---

## 9. Running the App

```bash
cd mobile-app
npm install
npx expo start
```

### Run on Android Emulator

```bash
npm run android
```

### Run on Physical Device

* Install **Expo Go**
* Scan QR code from terminal
* Ensure device is on the same network as backend

---

## 10. Build & Release

Recommended approach: **Expo EAS**

```bash
eas build --platform android
eas build --platform ios
```

Supports:

* CI/CD pipelines
* Internal testing
* App Store / Play Store releases

---

## 11. Best Practices & Notes

* Prefer dashboard APIs over composing multiple calls
* Cache master data (categories, accounts) locally
* Keep AI calls asynchronous (non-blocking UI)
* Do not hardcode environment values
* Always restart Expo after config changes

---

## ✅ Summary

The ExpenseApp mobile app is:

* **Cleanly architected**
* **AI-integrated**
* **Mobile-first**
* **Environment-configurable**
* **Production-ready**

Designed to scale from personal use to enterprise-grade finance applications.
