# AI Support Ticket Classifier & Salesforce Case Router

An enterprise API-led integration built with **MuleSoft (Mule 4)** that automatically reads incoming customer support complaints, classifies sentiment and urgency using an **LLM (Groq / LLaMA 3.3)**, and routes prioritized cases to **Salesforce Service Cloud**.

---

## 1. Project Overview (In Simple Words)

When a customer submits a complaint on a website (for example: *"My account was debited twice and customer service is not responding!"*), support teams usually have to read each ticket manually to figure out who should handle it first.

This project automates that entire process using **MuleSoft**:
1. **Receives:** Catches the support ticket via a secure REST API.
2. **Understands:** Sends the complaint text to an AI model to detect the emotion (*Angry, Frustrated, Neutral*) and urgency (*Critical, High, Medium, Low*).
3. **Decides & Routes:** If a customer is furious or facing a critical issue, MuleSoft prioritizes the ticket and immediately routes it to senior agents in Salesforce CRM.

---

## 2. API-Led Architecture

This project strictly follows MuleSoft's **3-Tier API-Led Connectivity** standard:

```
[ Customer / Postman / Web Form ]
               │
               ▼
┌─────────────────────────────────────────┐
│ 1. Experience API (Port: 8081)          │
│    - Validates incoming ticket data     │
│    - Governed by RAML 1.0 specification │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│ 2. Process API (Port: 8082)             │
│    - Duplicate check with Object Store  │
│    - Calls Groq AI for sentiment/urgency│
│    - Choice Router sets priority level  │
│    - Scatter-Gather for parallel audit  │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│ 3. System API (Port: 8083)              │
│    - Creates Case record in CRM/Salesforce│
│    - Returns confirmation & Case ID     │
└─────────────────────────────────────────┘
```

---

## 3. MuleSoft Technologies & Features Used

* **RAML 1.0:** Formally designed API contracts and data schemas.
* **DataWeave 2.0:** Complex JSON transformations, prompt engineering, and field enrichments.
* **Flow Control:** Choice Router for conditional business branching, Scatter-Gather for concurrent execution.
* **State Management:** Mule Object Store v2 for duplicate ticket detection (idempotency).
* **Reliability:** Global Error Handling with `On-Error-Propagate` and `On-Error-Continue`.
* **Security & Configuration:** Externalized environment properties (`config.yaml`).
* **Quality Assurance:** MUnit test suites with mocks and assertions.

---

## 4. Current Status: Chunk 1 Completed

- [x] **Chunk 1: Project Scaffold & Maven Setup**
  - Standard Mule 4 directory structure created.
  - Maven `pom.xml` configured with Mule 4.4.0 runtime, HTTP, Sockets, and Object Store connectors.
  - Externalized `config.yaml` for environment variables.
  - Log4j2 structured logging setup.
  - Initial project documentation and `.gitignore`.
- [ ] **Chunk 2: RAML 1.0 API Specification** (Next)
- [ ] **Chunk 3: Experience API (HTTP Listener & Validation)**
- [ ] **Chunk 4: Process API Core & Object Store**
- [ ] **Chunk 5: Groq AI Integration (DataWeave & HTTP Request)**
- [ ] **Chunk 6: Choice Router & Priority Routing**
- [ ] **Chunk 7: System API (Salesforce / Mock CRM)**
- [ ] **Chunk 8: Scatter-Gather Parallel Processing**
- [ ] **Chunk 9: Batch Job Bulk Processing**
- [ ] **Chunk 10: MUnit Test Suites**
- [ ] **Chunk 11: API Autodiscovery & CloudHub Deploy**
- [ ] **Chunk 12: Final Polish & Visual Verification**

---

## 5. Quick Start (Prerequisites)

* **Java JDK:** 8 or 11
* **Maven:** 3.6.x or newer
* **Anypoint Studio:** 7.x (Optional, can be viewed and opened in Studio directly)
* **Groq API Key:** Free key from [console.groq.com](https://console.groq.com)
