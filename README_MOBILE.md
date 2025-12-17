
# ExpenseApp Mobile App – React Native + Expo  
Comprehensive Mobile Documentation

## 1. Overview
The mobile application is built using **Expo**, **React Native**, and **TypeScript**. It provides a modern UI for expense tracking, analytics, budgeting, accounts, and AI-powered conversational finance capabilities.

---

## 2. Project Structure

```
mobile-app/
├── src/
│   ├── app/               # Screens (Auth, Tabs, Drawer, CRUD modules)
│   ├── components/        # Buttons, Cards, Chips, Charts
│   ├── contexts/          # AuthContext, ThemeContext
│   ├── services/          # API Service wrappers
│   ├── utils/             # Formatters, helpers
│   ├── styles/            # Global theme + styles
│   └── assets/            # Images, icons, fonts
```

---

## 3. Navigation

Using **Expo Router**:

### **Drawer**
- Dashboard  
- Transactions  
- Categories  
- Accounts  
- Budgets  
- AI Chat  
- Settings  

### **Tabs**
Used in dashboards & transaction analytics.

---

## 4. Core Screens

### **4.1 Authentication**
- Login  
- Register  
- Splash → Auto redirect based on JWT

### **4.2 Dashboard**
Includes:
- Monthly spend/income charts  
- Category pie chart  
- Quick KPIs  

### **4.3 Transactions**
Features:
- Add/Edit/Delete  
- AI auto-categorization  
- Voice input for descriptions  
- Filters: Year → Quarter → Month

### **4.4 Categories**
- CRUD categories  
- Active/Inactive toggles  

### **4.5 Budgets**
- Create category budgets  
- Alerts when exceeding limits  
- Budget health UI  

### **4.6 AI Chat**
- Text + Voice input  
- Ask questions like:
  - “How much did I spend on food last month?”
  - “Show last 10 transactions.”

---

## 5. State Management
Lightweight:  
- **AuthContext** → user/login/token  
- **Local component state** for forms  
- Network data fetched using API services

---

## 6. Theming & Styling
Dynamic themes:
- Light / Dark mode based on OS appearance  
- Color tokens stored in `/constants/theme.ts`

---

## 7. API Integration

All APIs wrapped in:

```
src/services/api.ts
```

Example Service File:
```
transactions.service.ts
categories.service.ts
ai.service.ts
```

---

## 8. Environment Variables
Create `.env`:
```
API_BASE_URL=http://localhost:8000
```

---

## 9. Running the Mobile App

```
cd mobile-app
npm install
npx expo start
```

To run on Android Studio:
```
npm run android
```

---

## 10. Build & Release
Expo EAS recommended:
```
eas build --platform android
eas build --platform ios
```

---

# End of README_MOBILE.md
