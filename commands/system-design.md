---

## description: System design discussion and diagramming

# System Design

## Usage

```
/system-design [topic]
```

**Examples:**

* `/system-design instagram feed`
* `/system-design payment service`
* `/system-design url shortener`

---

Help me think through the system design for: $ARGUMENTS

## Framework

Walk through these areas step by step. Ask me clarifying questions at each step before moving on.

---

### 1. Requirements

- What are the functional requirements?
- What are the non-functional requirements (latency, throughput, availability, consistency)?
- What scale are we designing for? (users, requests/sec, data volume)

---

### 2. High-Level Architecture

Define the system structure based on requirements.

#### Steps

1. Identify core components/services
   - What responsibilities exist?
   - How should they be grouped?

2. Define the main flow(s)
   - What is the critical user journey?
   - Step-by-step interaction between components

3. Define communication patterns
   - Sync (REST/gRPC) vs Async (Kafka/queues)
   - Justify trade-offs

4. Draw the architecture
   - Use text diagrams (Mermaid preferred)

---

### 3. Data Design

- What data needs to be stored?
- SQL vs NoSQL decisions for each entity (and why)
- Schema design
- Indexing strategy
- Partitioning/sharding if needed

---

### 4. API Design

- Key endpoints between services and to clients
- Authentication and authorization approach

---

### 5. Scaling & Performance

- Where are the bottlenecks?
- Caching strategy (what, where, TTL, invalidation)
- Database read replicas
- Connection pooling
- Query optimization
- Horizontal scaling approach

---

### 6. Reliability

- Single points of failure and how to eliminate them
- Failure modes and graceful degradation
- Monitoring, logging and alerting
- Circuit breakers and retries

---

## Output

At the end of each step, generate a **draft section** before moving on.

### Format

```md
## [Section Name] (Draft)

### Decisions

- Key decisions made

### Rationale

- Why those decisions were taken
- Trade-offs considered

### Open Questions

- What is still unclear or needs validation
```

---

## Final Output

After all steps are completed, consolidate everything into:

```md
# System Design: [Topic]

> Status: draft
> Created: [YYYY-MM-DD]
> Last updated: [YYYY-MM-DD]

## Requirements

...

## High-Level Architecture

...

## Data Design

...

## API Design

...

## Scaling & Performance

...

## Reliability

...

## Open Questions

- Cross-cutting concerns
- Trade-offs not fully resolved
```

---

## Save Design

After generating the final output, create a file with the design.

### Option A (recommended)

Save to a topic-based file:

```
/docs/system-design/{topic-slug}.md
```

Where `{topic-slug}` is:

- lowercase
- kebab-case
- example: `payment-service`, `instagram-feed`

### Option B (simple, less scalable)

Save to a single file:

```
/docs/system-design.md
```

Append the new design at the end of the file.

---

### Rules for saving

- Do NOT overwrite existing files without confirmation
- If file exists:
  - Ask whether to overwrite or append

- Always confirm after saving:
  - "Design saved to [path]"

---

## Behavior

- Do not skip steps
- Do not move forward without confirming with the user
- Ask questions in small batches (avoid overwhelming)
- Challenge vague answers and push for concrete numbers
- Do not assume — validate everything
- Keep answers concise but structured
- Always extract **decisions**, not just summaries

---

## Rules

- Explain trade-offs for every decision (e.g., "CP vs AP", "SQL vs NoSQL")
- Use real numbers when estimating (requests/sec, storage in GB, latency in ms)
- Prefer simplicity over premature optimization
- Design for failure (assume components will fail)
- Use standardized APIs (REST, GraphQL, gRPC)
- Always include observability (metrics, logs, tracing)
- Reference technologies I know: Project Technologies
- This is a learning exercise — teach me the reasoning, not just the answer
