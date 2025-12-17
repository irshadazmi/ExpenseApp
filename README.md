# ExpenseApp — Intelligent Personal Finance & AI Assistant

**ExpenseApp** is an enterprise-grade, AI-enhanced personal finance platform built as a reusable template for rapid extension.
It combines a cross-platform React Native (Expo) mobile frontend with a FastAPI + PostgreSQL backend and on-prem AI capabilities (local LLMs, embeddings, and Whisper). This README consolidates the project goals, architecture, features, developer instructions, and roadmap into a single, professional, ready-to-use reference.     

---

## Table of contents

1. [Project Summary](#project-summary)
2. [Key Features](#key-features)
3. [Architecture & Folder Layout](#architecture--folder-layout)
4. [Tech Stack](#tech-stack)
5. [API Endpoints (overview)](#api-endpoints-overview)
6. [AI Capabilities](#ai-capabilities)
7. [Security & Privacy](#security--privacy)
8. [Local Development — Quick Start](#local-development---quick-start)
9. [Docker & Database Setup](#docker--database-setup)
10. [Testing & Debugging](#testing--debugging)
11. [Configuration & Environment Variables](#configuration--environment-variables)
12. [Contribution Guidelines](#contribution-guidelines)
13. [Roadmap & Future Work](#roadmap--future-work)
14. [License](#license)

---

## Project summary

ExpenseApp focuses on usability and extensibility: a modular mobile UI (Drawer + Tabs + stacked CRUD), robust FastAPI backend (async SQLAlchemy repositories), and an AI layer for conversational analytics, safe SQL generation, and semantic memory via embeddings. The repository is intentionally structured to be a template for adding advanced AI features (RAG, local LLMs, semantic caching).  

---

## Key features

* **Expense & Income Management** — Add/edit/delete transactions; multi-currency support; category assignment. 
* **Budgets & Alerts** — Per-category budgets, near-limit notifications, usage vs. limit. 
* **Accounts & Master Data** — CRUD for accounts, categories, budgets with search + active toggles. 
* **Analytics Dashboard** — Pie, line, and bar charts; Year→Quarter→Month filters & KPIs. 
* **AI Chat / Insights** — Natural-language queries converted to safe SQL + formatted summaries; local LLMs (Ollama/Qwen) & embeddings. 
* **AI Categorization** — Auto-categorize transactions from descriptions with confidence scoring. 
* **Semantic Cache** — Persistent embedding store (pgvector) to reuse past answers and reduce latency. 
* **Voice Input** — Whisper integration for offline speech→text (supports multiple languages). 
* **Feedback System** — User feedback submission + admin replies and status management. 

---

## Architecture & folder layout

High level:

```
mobile-app/                 # Expo React Native app (TypeScript)
├── src/
│   ├── app/                # Screens (auth, drawer, tabs, CRUD modules, intro)
│   ├── components/         # Shared UI components (chips, cards, charts)
│   ├── contexts/           # Auth / Theme contexts
│   ├── services/           # API wrapper services (transaction, account, ai, ...)
│   └── styles/             # Theming and global styles
backend-api/
├── app/
│   ├── routers/            # FastAPI routers per module (auth, transactions, ai, ...)
│   ├── services/           # Business logic & AI services
│   ├── repositories/       # DB access layer (SQLAlchemy async)
│   ├── ai/                 # LLM + embedding utilities
│   └── main.py
docker/                     # DB init scripts, Docker Compose for PostgreSQL + pgvector
```

See the `src` and `backend-api` trees for the detailed module breakdown (services & files).  

---

## Tech stack

**Frontend**

* React Native (Expo), TypeScript
* Expo Router (Drawer + Tabs)
* Formik + Yup for forms, React Native Paper for components (optional)

**Backend**

* FastAPI (async)
* Python 3.10+ (recommend 3.11/3.12)
* SQLAlchemy (async), Pydantic schemas
* PostgreSQL (pgvector for embeddings), Dockerized DB option

**AI / Infra**

* Local Ollama for LLMs + embeddings (offline-first)
* Whisper.cpp for local STT (voice input)
* pgvector + HNSW indexing for ANN vector search (semantic cache). 

---

## API endpoints (overview)

Common endpoints provided by the backend template:

```
/auth/login
/auth/register
/auth/forgot-password

/transactions (GET, POST, PUT, DELETE)
/accounts (GET, POST, PUT, DELETE)
/categories (GET, POST, PUT, DELETE)
/budgets (GET, POST, PUT, DELETE)
/feedback (GET, POST, reply)
/settings
/ai/ask        # conversational & analytic queries
```

Each service exposes a concise repository + router contract; refer to `backend-api/app/routers/*` for exact route definitions. 

---

## AI capabilities (detailed)

* **Natural-language Q&A → SQL**: Multi-stage pipeline — keyword rules, intent classification, safe LLM-generated SQL (SELECT-only sandbox), then human-friendly formatting. 
* **Embeddings + Semantic Cache**: Each query can be vectorized and stored (768-dim embeddings). On new queries, system runs ANN similarity; high similarity returns cached AI output without re-running LLM. Great for latency and cost reduction. 
* **Auto Categorization**: Description → category prediction with confidence; safe fallback to default category. 
* **Whisper Voice Integration**: Local STT engine for voice queries (Hindi / English / Marathi supported) → text → intent pipeline. 
* **Guardrails & Safety**: SQL sandboxing, SELECT-only enforcement, and validation layers prevent unsafe DB writes from freeform LLM output. 

---

## Security & privacy

* JWT-based authentication with role-based access (User / SuperAdmin). Tokens stored securely (AsyncStorage + secure storage options recommended). 
* TLS for API endpoints in production; local dev can use HTTP.
* Local AI stack ensures user data stays on-premise (no cloud LLM calls unless explicitly configured). 
* Semantic cache stores user query context — treat as sensitive; apply appropriate DB encryption and access controls for production.

---

## Local development — quick start

### Prerequisites

* Node.js (16+ recommended)
* Python 3.11+
* Docker & Docker Compose (for DB) or local PostgreSQL
* `expo-cli` (optional) / `npx expo`

### 1. Clone & install

```bash
git clone <repo-url>
cd <repo-root>
```

#### Frontend

```bash
cd mobile-app
npm install
# Run Expo dev server:
npx expo start
# or
npm run ios   # / android, if configured
```

#### Backend

```bash
cd backend-api
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

Set `API_BASE_URL` in `/mobile-app/src/config/api.ts` (or `.env`) to point at the backend. 

---

## Docker & database setup

A dockerized PostgreSQL with `pgvector` extension is provided in `docker/`:

```bash
# from repo root (if docker-compose.yml present)
docker compose up -d
# then run migrations / init scripts
```

Make sure DB env vars (host, port, user, pass, database) are aligned between backend `.env` and Docker compose. The project includes SQL init scripts to create tables: `transactions`, `categories`, `budgets`, `feedback`, `users`, and the embedding vector column. 

---

## Testing & debugging

* Frontend: Expo DevTools and device logs
* Backend: run FastAPI with `--reload` and inspect interactive docs at `http://localhost:8000/docs` (OpenAPI).
* AI layer: Use the `/ai/ask` endpoint to validate intent parsing, safe SQL generation, and cache lookup. Log embedding distances and guardrail rejections during development. 

---

## Configuration & environment variables

Typical variables (example):

```
# backend .env
DATABASE_URL=postgresql+asyncpg://user:pass@localhost:5432/expenseapp
SECRET_KEY=replace-with-secure-key
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=60
PGVECTOR_DIM=768
OLLAMA_URL=http://localhost:11434
WHISPER_PATH=/path/to/whisper-cli
```

Frontend:

```
API_BASE_URL=http://localhost:8000
```

Store production secrets in a secure vault or environment configuration and **never** commit `.env` to source control.

---

## Contribution guidelines

* Fork → feature branch → PR.
* Follow existing folder and component patterns (services layer, context, reusable UI components). 
* Write unit tests for backend logic (services & repositories) and component tests / E2E for critical flows.
* For AI changes, add evaluation scripts and safety tests for SQL generation and guardrails.

---

## Roadmap & future work

**Phase 2**

* Improve intent classification & richer NLP rules. 

**Phase 3**

* Persistent semantic store with full LangChain retriever + pgvector production tuning (HNSW / M-ANN). 

**Phase 4**

* OCR bill scanning, offline-first sync, multi-device household sharing, export to Excel/PDF, push notifications. 

---

## Example queries for `/ai/ask`

* “How much did I spend on Food in November?”
* “Show last 5 transactions.”
* “Which categories exceeded budget this month?”
* Voice: “इस महीने मैंने कितना खर्च किया?”
  The AI pipeline will attempt cached semantic matches first and fall back to LLM SQL generation when necessary. 

---

## Troubleshooting tips

* If API responses fail, check `API_BASE_URL` and CORS settings. 
* For embedding/pgvector issues, verify the pgvector extension is installed and the DB connection env var points to the correct DB. 
* If local Ollama or Whisper aren't reachable, confirm their local services are running and `OLLAMA_URL` / `WHISPER_PATH` are correct.

---

## License

MIT License — see `LICENSE` file.

---

## Final notes

This consolidated README pulls together the UX, backend, and AI design decisions from the mobile and API templates to provide a clear developer and maintainer onboarding reference. Use this as the single source of truth while you extend ExpenseApp with advanced AI features, RAG flows, or enterprise deployments.
