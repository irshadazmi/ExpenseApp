# Intelligent Personal Finance & AI Assistant

**FastAPI · PostgreSQL · React Native · Local AI**

---

## Introduction

**ExpenseApp** is a modern, AI-powered personal finance application built for individuals and small teams who want **clear visibility into spending, budgets, and financial behavior**, without sacrificing **data privacy or control**.

Unlike typical finance apps that rely heavily on cloud-based AI services, ExpenseApp adopts a **privacy-first, local AI approach**, where intelligent insights are generated **on-device or within your own infrastructure**.

The platform combines:

* 📱 **React Native (Expo)** mobile application for cross-platform UX
* ⚙️ **FastAPI + PostgreSQL** backend for scalable, secure APIs
* 🧠 **Local AI** for insights, forecasting, anomaly detection, and voice interaction

ExpenseApp is designed as a **production-ready reference architecture** for teams building **finance + AI applications**, not just a demo or prototype.

---

## Key Features

### Core Finance

#### **Expense & Income Management**

Create, edit, and manage income and expense transactions with support for multiple accounts and categories.
The data model is optimized for analytics, forecasting, and AI-driven insights.

#### **Budgets & Alerts**

Define **monthly category budgets** with automatic detection of:

* Near-limit usage
* Over-budget conditions

Alerts are generated early to help users adjust behavior before overspending.

#### **Accounts & Master Data**

Manage accounts, categories, and budgets with:

* Enable/disable toggles
* Clean separation between master data and transactions
* Simple CRUD APIs designed for mobile workflows

#### **Analytics Dashboard**

An interactive dashboard providing:

* Pie, bar, and line charts
* **Year → Quarter → Month** drill-downs
* Key financial KPIs at a glance

All dashboard data is served via optimized backend aggregation APIs.

---

## AI Features

### Conversational AI (Text + Voice)

Natural-language queries such as:

> “How much did I spend on Food last month?”

Supported via text and offline **Whisper** voice input, translated into **safe, read-only SQL**.

### Forecasting, Anomaly Detection & Explainability

* Forecast overlays on charts
* Budget overshoot detection
* Transparent, human-readable AI explanations

### Semantic Cache (pgvector)

* Stores embeddings of past AI queries
* Reuses semantically similar results
* Improves latency and reduces LLM calls

---

## Technology Stack

**Frontend**

* React Native (Expo), TypeScript, Expo Router

**Backend**

* FastAPI (async)
* PostgreSQL + pgvector
* SQLAlchemy (async)

**AI**

* Ollama (local LLMs & embeddings)
* Whisper.cpp
* Custom forecasting & anomaly engines

**Infrastructure**

* Docker & Docker Compose
* APScheduler
* Cloud-ready (Kubernetes compatible)

---

## Architecture Overview

```
mobile-app/        → React Native (Expo)
backend-api/       → FastAPI services
postgres (pgvector)→ Core + AI semantic storage
ollama             → Local LLM runtime
```

---

## Getting Started

### Prerequisites

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

### 2️⃣ Start Database (Docker)

```bash
docker compose up -d
```

This starts PostgreSQL (with pgvector) and supporting services.

---

### 3️⃣ Restore Database Backup (Optional but Recommended)

> **Important (Windows users):**
> Always use `-i` (stdin) and **do not use `-t`** when restoring.

#### ✅ Restore a standard `.sql` dump (COPY or INSERT based)

```powershell
docker exec -i expense_pg psql -U postgres -d expensedb < expensedb_backup.sql
```

This command works for:

* COPY-based dumps (default `pg_dump`)
* INSERT-based dumps (`--inserts`, `--column-inserts`)

#### What gets restored

* Users & roles
* Categories & accounts
* Budgets & transactions
* Feedbacks & tokens
* Semantic cache (pgvector embeddings)
* User financial profiles

---

### ⚠️ pgvector Requirement (Important)

If restoring into a **fresh database**, ensure the pgvector extension exists **before** restore:

```powershell
docker exec -i expense_pg `
psql -U postgres -d expensedb -c "CREATE EXTENSION IF NOT EXISTS vector;"
```

---

### 🔁 Restoring a Custom / Compressed Dump (`.backup`)

If the backup was created using:

```bash
pg_dump -Fc
```

Then **do NOT use `psql`**. Use `pg_restore` instead:

```powershell
docker exec -i expense_pg `
pg_restore -U postgres -d expensedb < expensedb.backup
```

---

### 4️⃣ Backend Setup

```bash
cd backend-api
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

uvicorn app.main:app --host 0.0.0.0 --port 80 --reload
```

API docs (Swagger):

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

### 📌 Mobile App Runtime Configuration (Expo `app.json`)

ExpenseApp uses Expo’s `extra` configuration for runtime values.

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

#### Access in code

```ts
import Constants from "expo-constants";

export const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL;
```

> Restart Expo after changing `app.json`.

---

## Configuration (Backend)

```env
DB_USER=postgres
DB_PASSWORD=your-password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=expensedb

SECRET_KEY=your-secret
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_EMBED_MODEL=nomic-embed-text
```

---

## Security & Privacy

* JWT-based authentication
* Role-based access control
* Local AI by default
* No AI-initiated DB writes
* Strict SELECT-only SQL guardrails

---

## Roadmap

* OCR bill scanning
* PDF / Excel exports
* Push notifications
* Advanced forecasting (ARIMA / Prophet)
* Admin analytics dashboard

---

## License

MIT License

---

## Final Note

**ExpenseApp is not just an expense tracker — it is an AI-assisted financial decision platform**, designed for transparency, extensibility, and privacy-first intelligence.
