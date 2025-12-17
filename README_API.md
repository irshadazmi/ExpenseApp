
# ExpenseApp Backend – FastAPI + PostgreSQL  
Comprehensive API Documentation

## 1. Overview
The ExpenseApp backend is a modular, async FastAPI service that provides secure APIs for authentication, transactions, budgets, categories, accounts, AI analytics, semantic search, and voice processing.  
It follows clean architecture principles: Routers → Services → Repositories → Database.

---

## 2. Architecture

```mermaid
flowchart TD
    Client[Mobile App] --> API[FastAPI Backend]
    API --> Auth[Auth Router]
    API --> Trans[Transactions Router]
    API --> Cat[Categories Router]
    API --> Bud[Budgets Router]
    API --> Acc[Accounts Router]
    API --> Feed[Feedback Router]
    API --> AI[AI Router]

    AI --> LLM[Local LLM / Ollama]
    AI --> Embed[Embedding Generator]
    AI --> Cache[Semantic Cache (pgvector)]

    DB[(PostgreSQL + pgvector)] --> Repo[Repositories Layer]
```

---

## 3. Folder Structure

```
backend-api/
├── app/
│   ├── routers/          # FastAPI route definitions
│   ├── services/         # Business logic (auth, ai, transaction, budgets, etc.)
│   ├── repositories/     # Async SQLAlchemy DB interactions
│   ├── ai/               # LLM, embeddings, SQL guardrails
│   ├── models/           # SQLAlchemy ORM models
│   ├── schemas/          # Pydantic schemas
│   ├── core/             # Config, JWT, security helpers
│   └── main.py           # App entrypoint
```

---

## 4. API Modules

### **4.1 Authentication**
- `/auth/login`
- `/auth/register`
- `/auth/forgot-password`

Features:
- JWT-based auth
- Role-based access
- Password hashing (bcrypt)

---

### **4.2 Transactions**
- CRUD for expense/income
- Category + account linking
- Automatic AI categorization (optional)

Endpoints:
```
GET /transactions
POST /transactions
PUT /transactions/{id}
DELETE /transactions/{id}
```

---

### **4.3 Categories**
```
GET /categories
POST /categories
PUT /categories/{id}
DELETE /categories/{id}
```

---

### **4.4 Budgets**
- Monthly category budgets
- Budget limit alerts
- Analytics integration

```
GET /budgets
POST /budgets
PUT /budgets/{id}
DELETE /budgets/{id}
```

---

### **4.5 Accounts**
```
GET /accounts
POST /accounts
PUT /accounts/{id}
DELETE /accounts/{id}
```

---

### **4.6 Feedback**
```
POST /feedback
GET /feedback
POST /feedback/{id}/reply
```

---

### **4.7 AI Endpoints**

#### `/ai/ask`
Natural language → SQL → formatted result.

Pipeline:
1. Intent classification  
2. Semantic memory lookup (pgvector)  
3. Safe SQL generation (LLM with guardrails)  
4. Query execution  
5. Final natural-language summary  

#### `/ai/speech`
Whisper voice transcription.

---

## 5. Database

### SQLAlchemy Models:
- User  
- Transactions  
- Categories  
- Accounts  
- Budgets  
- Feedback  
- EmbeddingCache (vector field)

### pgvector Usage
- 768-d embedding column
- HNSW index for ANN search

---

## 6. Environment Variables

```
DATABASE_URL=
SECRET_KEY=
PGVECTOR_DIM=768
OLLAMA_URL=http://localhost:11434
WHISPER_PATH=
```

---

## 7. Running Locally

```
uvicorn app.main:app --reload --port 8000
```

Visit API docs:  
👉 `http://localhost:8000/docs`

---

## 8. Deployment Notes
- Use Gunicorn + Uvicorn Workers  
- Enable HTTPS  
- Apply DB migrations  
- Secure JWT keys  
- Horizontal scaling with Kubernetes supported  

---

# End of README_API.md
