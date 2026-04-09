# 💰 ExpenseApp

**Personal Finance Management · FastAPI · PostgreSQL · React Native**

---

## 📌 Overview

**ExpenseApp** is a modern personal finance management solution designed for individuals and small teams who need **clear visibility into expenses, budgets, and financial trends**.

It focuses on:

* 🔒 **Privacy-first design** (no AI, no external data processing)
* ⚡ **High performance** with async backend APIs
* 📊 **Actionable insights** through analytics dashboards
* 📱 **Seamless mobile experience** using React Native

This project also serves as a **production-ready reference architecture** for building scalable financial applications.

---

## ✨ Key Features

### 💵 Expense & Income Management

* Track income and expenses across multiple accounts
* Categorize transactions for better analysis
* Simple and intuitive CRUD operations

---

### 📊 Budgets & Alerts

* Define **monthly category budgets**
* Automatic detection of:

  * Near-limit usage
  * Budget breaches
* Helps users proactively control spending

---

### 🗂️ Accounts & Master Data

* Manage:

  * Accounts
  * Categories
  * Budgets
* Enable/disable entities without deletion
* Clean separation between **master data** and **transactions**

---

### 📈 Analytics Dashboard

* Interactive visualizations:

  * Pie charts
  * Bar charts
  * Trend lines
* Drill-down support:

  * **Year → Quarter → Month**
* Backend-driven aggregated APIs for performance

---

## 🏗️ Technology Stack

### **Frontend**

* React Native (Expo)
* TypeScript
* Expo Router

### **Backend**

* FastAPI (async)
* PostgreSQL
* SQLAlchemy (async ORM)

### **Infrastructure**

* Docker & Docker Compose
* APScheduler (background jobs)
* Kubernetes-ready architecture

---

## 🧩 Project Structure

```
ExpenseApp/
│
├── mobile-app/        # React Native (Expo)
├── backend-api/       # FastAPI backend
└── docker-compose.yml
```

---

## 🚀 Getting Started

### ✅ Prerequisites

* Node.js 16+
* Python 3.11+
* Docker & Docker Compose
* PostgreSQL client (`psql`)
* Expo CLI (optional)

---

### 1️⃣ Clone Repository

```bash
git clone <your-repo-url>
cd ExpenseApp
```

---

### 2️⃣ Start Database

```bash
docker compose up -d
```

This starts PostgreSQL and required services.

---

### 3️⃣ Restore Database (Optional)

#### Restore `.sql` dump

```bash
docker exec -i expense_pg psql -U postgres -d expensedb < expensedb_backup.sql
```

#### Restore `.backup` dump

```bash
docker exec -i expense_pg pg_restore -U postgres -d expensedb < expensedb.backup
```

#### Ensure Extensions (if fresh DB)

```bash
docker exec -i expense_pg \
psql -U postgres -d expensedb -c "CREATE EXTENSION IF NOT EXISTS vector;"
```

---

### 4️⃣ Backend Setup

```bash
cd backend-api

python -m venv .venv
source .venv/bin/activate     # Windows: .venv\Scripts\activate

pip install -r requirements.txt

uvicorn app.main:app --host 0.0.0.0 --port 80 --reload
```

📘 Swagger Docs:

```
http://localhost/docs
```

---

### 5️⃣ Mobile App Setup

```bash
cd mobile-app

npm install
npx expo start
```

---

## ⚙️ Mobile Configuration (Expo)

Update `app.json`:

```json
{
  "expo": {
    "extra": {
      "API_BASE_URL": "http://<your-ip>/api",
      "TOKEN_EXPIRY_MINUTES": 60
    }
  }
}
```

### Access in Code

```ts
import Constants from "expo-constants";

export const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL;
```

> Restart Expo after changes.

---

## 🔐 Backend Configuration

Create `.env` file:

```env
DB_USER=postgres
DB_PASSWORD=your-password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=expensedb

SECRET_KEY=your-secret
```

---

## 🔒 Security

* JWT-based authentication
* Role-based access control (RBAC)
* Secure API design for mobile-first usage

---

## 🛣️ Roadmap

* 📄 PDF / Excel exports
* 🔔 Push notifications
* 🧾 OCR-based bill scanning
* 📊 Advanced financial forecasting
* 🧑‍💼 Admin analytics dashboard

---

## 📄 License

MIT License

---

## 💡 Notes

* Designed for **extensibility and scalability**
* Clean separation of frontend and backend
* Suitable for **startup MVPs or enterprise-grade systems**