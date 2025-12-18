# 🤖 ExpenseApp AI System Documentation

**LLM · pgvector · Whisper · Semantic Intelligence**

---

## 1. Overview

The **ExpenseApp AI System** is a **production-grade, modular AI engine** that enables natural, conversational interaction with financial data.

It powers:

* 💬 Conversational AI (chat)
* 🎤 Voice-based interaction
* 🧠 Semantic memory & caching
* 📊 AI-generated insights & explanations
* 🏷️ Automatic transaction categorization

The system is designed to be:

* **Mobile-first**
* **Secure by design**
* **Offline-capable (local LLMs)**
* **Cloud-deployable**
* **Incrementally extensible** (RAG, agents, workflows)

---

## 2. AI Engine – High-Level Architecture

```mermaid
flowchart TD
    User -->|Voice| VoiceAPI[/ai/voice-chat]
    User -->|Text| ChatAPI[/ai/chat]

    VoiceAPI --> Whisper[Whisper STT]
    Whisper --> TextQuery

    ChatAPI --> TextQuery

    TextQuery --> Intent[Intent & Query Analysis]

    Intent --> VectorSearch[Semantic Cache Lookup\npgvector]

    VectorSearch -->|High Similarity| Cached[Reuse Cached Result]
    VectorSearch -->|Low Similarity| LLM[Local LLM (Ollama)]

    LLM --> SQLGen[Safe SQL Generator]
    SQLGen --> Guard[SQL Guardrails]
    Guard --> DB[(PostgreSQL)]

    DB --> Result[Query Result]
    Result --> Summary[Natural Language Summary]

    Summary --> Store[Store Embedding + Response]
    Cached --> Final[Send Response]
    Store --> Final
```

---

## 3. AI Router & API Surface

All AI functionality is exposed via the **AI Router**:

```
/ai/chat
/ai/voice-chat
/ai/categorize
/ai/insights
```

These APIs are **stateless**, **JWT-protected**, and optimized for **mobile consumption**.

---

## 4. Core AI Modules

---

### 4.1 Intent & Query Analysis

**Purpose:**
Convert user language into a structured, executable intent.

Handles:

* Aggregations (`total`, `average`, `highest`)
* Entities (categories, accounts)
* Time ranges (month, quarter, year)
* Contextual follow-ups

Techniques:

* Lightweight rule-based parsing
* LLM-assisted disambiguation
* Time & numeric normalization

---

### 4.2 Semantic Cache (pgvector)

To reduce latency and LLM cost, ExpenseApp uses a **semantic cache**.

**How it works:**

* Each AI query → embedding (768-d)
* Stored in PostgreSQL using `pgvector`
* ANN search via HNSW index

**Cache Hit Rule:**

```
cosine_distance < 0.15 → reuse response
```

Benefits:

* ⚡ Faster responses
* 💸 Lower inference cost
* 🔁 Consistent answers

---

### 4.3 Local LLM Integration (Ollama)

The AI engine uses **local LLMs** by default.

Supported models:

* Llama 3
* Qwen 2.5
* Mistral

Used for:

* SQL generation
* Natural-language summaries
* Categorization logic
* Insight explanations

This ensures:

* Privacy-first processing
* Offline capability
* Predictable latency

---

### 4.4 Safe SQL Generator & Guardrails

To prevent unsafe execution, **strict SQL guardrails** are enforced.

Rules:

* ✅ `SELECT` only
* ❌ No `INSERT`, `UPDATE`, `DELETE`
* ✅ Whitelisted tables only
* ❌ No dynamic joins
* ❌ No subqueries beyond limits

Execution flow:

```
LLM → SQL draft → validation → execution
```

This protects the database while enabling powerful analytics.

---

### 4.5 Voice AI (Whisper)

**Endpoint:**

```
POST /ai/voice-chat
```

Flow:

```
Mobile mic → audio (.wav) → Whisper → text → AI pipeline
```

Supported languages:

* English
* Hindi
* Marathi

Optimized for:

* Low-bandwidth uploads
* Mobile latency constraints

---

### 4.6 AI Categorization Engine

**Endpoint:**

```
POST /ai/categorize
```

Inputs:

* Transaction description
* Merchant info (if any)

Outputs:

* Predicted category
* Confidence score

Fallback:

* Category defaults to **“Uncategorized”** if confidence is low

Used by:

* Transaction creation
* Expense imports
* Corrections learning loop (future)

---

### 4.7 AI Insights Engine

**Endpoint:**

```
GET /ai/insights?user_id=...
```

Generates:

* Spending trends
* Anomaly detection
* Budget overshoot warnings
* Plain-language explanations

Used in:

* Dashboard “Insights” cards
* Monthly summaries
* Notifications (future)

---

## 5. Database & Embeddings

### Embedding Table

* 768-d vector column
* Indexed using HNSW
* Stores:

  * Query embedding
  * Response text
  * Metadata (user, timestamp)

Example debug query:

```sql
SELECT * FROM embedding_cache
ORDER BY created_at DESC;
```

---

## 6. Mobile App Integration Notes

Best practices for mobile developers:

* Prefer **/ai/insights** for dashboards (not raw queries)
* Use **/ai/chat** for conversational UI
* Use **/ai/voice-chat** asynchronously
* Do not block UI on AI calls
* Cache AI responses client-side where possible

---

## 7. Debugging & Observability

### Enable AI Debug Logs

```
APP_AI_DEBUG=true
```

Logs include:

* Intent classification output
* SQL generated
* Cache hit/miss
* Execution timing

### Whisper Debugging

* Verify model path
* Test standalone:

```
whisper-cli test.wav
```

---

## 8. Extensibility Roadmap

Planned enhancements:

* RAG over financial documents
* Multi-step agent workflows
* Personalized recommendations
* Learning from user corrections
* Predictive budgeting

The AI engine is designed to evolve **without breaking mobile APIs**.

---

## 9. Key Design Guarantees

✔ No destructive SQL
✔ Deterministic execution
✔ Privacy-first AI
✔ Mobile-optimized latency
✔ Cloud & on-device compatible

---

## ✅ Summary

The ExpenseApp AI system transforms financial data into:

* **Conversations**
* **Insights**
* **Voice-driven actions**

while remaining **secure, explainable, and extensible**.

---