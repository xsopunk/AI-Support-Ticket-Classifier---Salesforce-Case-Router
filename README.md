# AI Support Ticket Classifier & Salesforce Case Router

An enterprise API-led integration built with **MuleSoft (Mule 4)** that automatically ingests customer support tickets, classifies sentiment and urgency using an **LLM (Groq / LLaMA 3.3)**, and routes prioritized cases into **Salesforce Service Cloud**.

---

## 1. Project Overview

Customer support centers receive hundreds of inquiries and complaints each day. Manually triaging each ticket introduces delays, causing critical customer issues to sit unaddressed in queues.

This project solves this challenge by implementing an automated **API-Led Integration Pipeline**:
* **Ingestion:** Securely receives support tickets from customer touchpoints via an Experience API.
* **Intelligent Triage:** Orchestrates an asynchronous analysis via a GenAI LLM (Groq API) to assess customer sentiment (*Angry, Frustrated, Neutral, Satisfied*) and incident urgency (*Critical, High, Medium, Low*).
* **Automated Routing:** Implements conditional business logic (Choice Router) to categorize priority and route high-severity cases directly into Salesforce Service Cloud for immediate agent attention.
* **Resilience & Performance:** Uses Object Store for request deduplication and caching, Scatter-Gather for parallel auditing, and comprehensive global error handling.

---

## 2. API-Led Architecture

The solution adheres strictly to MuleSoft's 3-Tier API-Led Connectivity paradigm:

```
[ Customer / Web Portal / Mobile App ]
                  │
                  ▼
┌──────────────────────────────────────────────┐
│  1. Experience API (Port: 8081)               │
│     - Public-facing REST endpoint            │
│     - Contract governed by RAML 1.0          │
│     - Schema validation & client response    │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│  2. Process API (Port: 8082)                  │
│     - Business logic & orchestration         │
│     - Idempotency check via Object Store     │
│     - AI prompt construction & Groq API call │
│     - Urgency classification & Choice Router │
│     - Parallel audit logging (Scatter-Gather)│
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│  3. System API (Port: 8083)                   │
│     - Decoupled CRM System of Record         │
│     - Case creation in Salesforce Service CRM│
│     - Returns generated Case Number & Status │
└──────────────────────────────────────────────┘
```

---

## 3. Technology Stack & MuleSoft Components

* **Runtime:** Mule 4.4.0
* **API Specification:** RAML 1.0 with modular DataType fragments and JSON examples
* **Transformation Language:** DataWeave 2.0
* **Flow Routers & Scopes:** Choice Router, Scatter-Gather, Sub-flows, Flow References
* **Connectors:** HTTP Connector, Sockets Connector, Object Store v2
* **Error Handling:** Global Error Handler (`On-Error-Propagate` and `On-Error-Continue`)
* **Testing:** MUnit 2.3.14 with mocking and assertions
* **Configuration:** Externalized YAML properties (`config.yaml`) and secure property masks
* **AI Provider:** Groq Cloud API (LLaMA 3.3 70B Versatile)

---

## 4. API Endpoints

| Layer | Method | Path | Description |
|:---|:---|:---|:---|
| Experience | `POST` | `/api/tickets` | Ingest and classify a single support ticket |
| Experience | `GET` | `/api/tickets/{ticketId}` | Retrieve current processing status of a ticket |
| Experience | `POST` | `/api/tickets/bulk` | Bulk ingestion for ticket batch processing |
| Experience | `GET` | `/api/health` | Service health and uptime check |
| Process | `POST` | `/api/process-ticket` | Orchestrate AI analysis, routing, and CRM call |
| System | `POST` | `/api/crm/cases` | Create Case record in CRM/Salesforce |

---

## 5. Setup & Running Locally

### Prerequisites
* Java JDK 8 or 11
* Apache Maven 3.6+
* Anypoint Studio 7.x (Optional for graphical flow visualization)

### Configuration
Update `src/main/resources/config.yaml` with your Groq API key:
```yaml
groq:
  apiKey: "gsk_your_groq_api_key_here"
```

### Build & Run
```bash
# Clean and package the application
mvn clean package

# Run MUnit tests
mvn test
```
