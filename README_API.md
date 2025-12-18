# 📘 ExpenseApp Backend API

**FastAPI · PostgreSQL · pgvector · AI Engine**

Enterprise-grade backend powering the ExpenseApp mobile application with secure APIs, analytics, and AI-assisted insights.

---

## 1. Overview

The **ExpenseApp Backend** is a **modular, async FastAPI service** designed to support a modern mobile application built with **React Native + Expo**.

It provides:

* Secure authentication (JWT)
* Core financial CRUD APIs
* Dashboard & analytics APIs
* AI-powered features (chat, voice, categorization, insights)
* Semantic memory using **pgvector**

### Architectural Principles

* Async-first (FastAPI + SQLAlchemy Async)
* Clean architecture:

```
Routers → Services → Repositories → Database
```

* Mobile-friendly APIs (simple payloads, predictable responses)

---

## 2. High-Level Architecture

```mermaid
flowchart TD
    Mobile[Mobile App\nReact Native + Expo] --> API[FastAPI Backend]

    API --> Auth[Auth Router]
    API --> User[User Router]
    API --> Txn[Transaction Router]
    API --> Cat[Category Router]
    API --> Acc[Account Router]
    API --> Bud[Budget Router]
    API --> Dash[Dashboard Router]
    API --> Feed[Feedback Router]
    API --> AI[AI Router]

    AI --> LLM[Local LLM (Ollama)]
    AI --> Whisper[Whisper STT]
    AI --> Embed[Embeddings Generator]
    AI --> Vector[Semantic Cache\npgvector]

    Repo[Repositories] --> DB[(PostgreSQL + pgvector)]
```

---

## 3. Folder Structure

```
backend-api/
└─ app/
   ├─ ai/               # AI logic (chat, voice, categorization, insights)
   ├─ jobs/             # Scheduled / background AI jobs
   ├─ core/             # Core configs (DB, security, settings)
   ├─ middlewares/      # Auth, CORS, exception handling
   ├─ models/           # SQLAlchemy ORM models
   ├─ repositories/     # DB access layer
   ├─ routers/          # API routers (REST endpoints)
   ├─ schemas/          # Pydantic request/response schemas
   ├─ seed/             # Fake data seeding utilities
   ├─ services/         # Business logic + AI orchestration
   ├─ utils/            # Exceptions, helpers, constants
   └─ main.py           # FastAPI entry point
```

---

## 4. Authentication & Security

### Auth Mechanism

* JWT-based authentication
* OAuth2 password flow
* Token passed from mobile app in:

```
Authorization: Bearer <token>
```

### Endpoints

```
POST   /auth/register
POST   /auth/login
GET    /auth/me
PUT    /auth/{user_id}
```

### Mobile App Usage

* Login → store JWT securely
* Attach token to every API call
* `/auth/me` used on app launch to restore session

---

## 5. Core Business APIs (Mobile-First)

### 5.1 Users

```
POST   /users
GET    /users
GET    /users/{user_id}
PUT    /users/{user_id}
DELETE /users/{user_id}

GET    /users/searchByEmail
GET    /users/searchByPhone
```

Use cases:

* Profile management
* Admin/support lookup
* Account operations

---

### 5.2 Accounts

```
GET    /accounts
GET    /accounts/{account_id}
POST   /accounts
PUT    /accounts/{account_id}
DELETE /accounts/{account_id}
```

Used for:

* Cash / Bank / Wallet accounts
* Dashboard summaries
* Transaction grouping

---

### 5.3 Categories

```
GET    /categories
GET    /categories/{category_id}
POST   /categories
PUT    /categories/{category_id}
DELETE /categories/{category_id}
```

Used by:

* Transactions
* Budgets
* AI categorization & analytics

---

### 5.4 Transactions

```
GET    /transactions
GET    /transactions/{transaction_id}
POST   /transactions
PUT    /transactions/{transaction_id}
DELETE /transactions/{transaction_id}

GET    /transactions/grouped-by-category
GET    /transactions/summary-by-category
```

Optimized for:

* Expense lists
* Monthly summaries
* Category-wise charts

---

### 5.5 Budgets

```
GET    /budgets
GET    /budgets/{budget_id}
GET    /budgets/by-month
GET    /budgets/total-amount

POST   /budgets/create-all-budgets
POST   /budgets/save-all-budgets
```

Notes:

* Month-aware budgets
* Bulk save supported
* Optimized for dashboards

---

### 5.6 Dashboard (Aggregated APIs)

```
GET /dashboard/summary
GET /dashboard/categories
GET /dashboard/recent
GET /dashboard/accounts
```

Purpose:

* Reduce mobile API calls
* Serve pre-aggregated analytics
* Power dashboard & insights UI

---

### 5.7 Feedback

```
GET    /feedback
GET    /feedback/{feedback_id}
POST   /feedback
PUT    /feedback/{feedback_id}
DELETE /feedback/{feedback_id}
```

Used for:

* User feedback
* Admin replies
* Support workflows

---

## 6. AI APIs (Phase-4 Features)

### 6.1 AI Chat

```
POST /ai/chat
```

Example:

> “How much did I spend on food last month?”

Pipeline:

1. Intent analysis
2. Semantic cache lookup (pgvector)
3. Safe SQL generation
4. Query execution
5. Natural-language response

---

### 6.2 Voice Chat

```
POST /ai/voice-chat
```

* Accepts audio file + `user_id`
* Uses Whisper STT
* Feeds transcript into chat pipeline

Mobile usage:
🎤 Hands-free finance queries

---

### 6.3 AI Categorization

```
POST /ai/categorize
```

Used during:

* Transaction creation
* Imports

Returns:

* Best-matched category
* Confidence score

---

### 6.4 AI Insights

```
GET /ai/insights?user_id=...
```

Returns:

* Spending trends
* Anomalies
* Forecast signals
* Explainable insights

Used by:

* Dashboard “Insights” cards

---

## 7. Database & pgvector

### Core Models

* User
* Account
* Category
* Transaction
* Budget
* Feedback
* EmbeddingCache

### pgvector Usage

* 768-dimensional embeddings
* HNSW index
* Used for:

  * Semantic cache
  * AI response reuse
  * Faster AI queries

---

## 8. Environment Variables

```env
DATABASE_URL=
SECRET_KEY=
PGVECTOR_DIM=768
OLLAMA_URL=http://localhost:11434
WHISPER_PATH=
```

---

## 9. Running Locally

```bash
uvicorn app.main:app --host 0.0.0.0 --port 80 --reload
```

Swagger UI:

```
http://localhost/docs
```

---

## 10. Database Backup & Restore (Important)

### 🔹 Restore a Standard `.sql` Backup (COPY or INSERT)

> **Windows-safe command (recommended):**

```powershell
docker exec -i expense_pg psql -U postgres -d expensedb < expensedb_backup.sql
```

✔ Works with default `pg_dump` (COPY)
✔ Works with `--inserts` / `--column-inserts`
✔ No TTY issues on Windows

### 🔹 Ensure pgvector Extension Exists

If restoring into a fresh database:

```powershell
docker exec -i expense_pg `
psql -U postgres -d expensedb -c "CREATE EXTENSION IF NOT EXISTS vector;"
```

### 🔹 Restore a Custom / Compressed Dump (`.backup`)

If the backup was created using:

```bash
pg_dump -Fc
```

Restore using `pg_restore` (NOT `psql`):

```powershell
docker exec -i expense_pg `
pg_restore -U postgres -d expensedb < expensedb.backup
```

---

## 11. Deployment Notes

* Stateless FastAPI containers
* PostgreSQL with pgvector enabled
* Gunicorn + Uvicorn workers
* Kubernetes-ready
* Horizontal scaling supported
* AI engine can run on separate nodes

---

## 12. Mobile App Integration Tips

* Prefer **dashboard APIs** over multiple small calls
* Cache categories & accounts locally
* Call AI APIs asynchronously
* Always pass `user_id` explicitly (AI & dashboard APIs)

---

## ✅ Summary

This backend is:

* **Mobile-optimized**
* **AI-first**
* **pgvector-powered**
* **Cloud-ready**
* **Production-grade**

Designed to scale from personal finance to enterprise analytics.
