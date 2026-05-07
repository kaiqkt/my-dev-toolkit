---

name: sdd
description: >
  Creates detailed per-feature Software Design Documents from a system design output.
  Reads a system design file, extracts features, and guides the user through an interactive
  spec creation process — one feature at a time. Each spec covers problem, scope, technical
  design (API contracts, data model, dependencies), acceptance criteria, edge cases, and
  validation expectations. Use this skill whenever the user wants to write a spec, create
  a feature spec, detail a component, or bridge system design into implementation-ready
  documentation — even if they just say "cria spec para", "escreve spec", "detalhar feature",
  "write spec for", "specify feature", "criar especificação", "quero especificar", or similar
  natural language around feature specification.

---

# Skill: sdd

Creates detailed per-feature Software Design Documents from a system design output.
Reads a system design file, extracts features, and guides an interactive spec creation
process — one feature at a time.

---

## Usage

```
/sdd [path-to-system-design]
```

Examples:
- `/sdd docs/system-design/payment-service.md`
- `/sdd` — auto-discovers system design files and asks which to use
- "cria spec para auth-refresh-token"
- "write spec for billing retry policy"

---

## Behavior

- Follow steps in order
- Do NOT skip sections
- Do NOT move forward without confirmation
- Ask questions in small batches
- Pre-fill from system design context — let user refine, not retype
- Challenge vague acceptance criteria — push for testable, concrete conditions
- Loop until user says done

---

# Flow

---

## Step 1 — Load System Design

If path provided:
- Read the file at the given path

If no path provided:
- Search for files in `docs/system-design/`
- If one file found: use it, inform user
- If multiple found: list them and ask which to use
- If none found: ask user to provide path or paste content

---

## Step 2 — Extract Features

Parse the system design and extract features from:
- **High-Level Architecture** section — components, services, flows
- **Data Design** section — major entities and their boundaries
- **API Design** section — key endpoint groups

Present the extracted list:

```
Features extracted from [filename]:

1. feature-one
2. feature-two
3. feature-three
...

Would you like to add or remove any? Which one do you want to spec first?
```

Accept user additions. Remove on request. Proceed when user selects a feature.

---

## Step 3 — Interactive Spec per Feature

For each selected feature, guide through three focused blocks.

### Block 1 — Context

Pre-fill from system design where possible. Ask user to confirm or refine:

- What specific problem does this feature solve?
- What does this spec cover? (scope)
- What is explicitly out of scope?

Generate draft after block. Confirm before continuing.

### Block 2 — Technical Design

Ask focused questions:

**API Contracts:**
- What are the main endpoints?
- Request/response payloads?
- Error cases and status codes?

**Data Model:**
- Which entities are created, read, updated, or deleted?
- Relevant fields and types?
- Relationships to other entities?

**Dependencies:**
- Internal services or components required?
- External APIs or third-party integrations?
- Infrastructure dependencies (queues, cache, storage)?

Generate draft after block. Confirm before continuing.

### Block 3 — Behavioral

Ask focused questions:

**Acceptance Criteria:**
- What must be true for this feature to be considered done?
- List as concrete, testable checkboxes

**Edge Cases:**
- What can go wrong?
- What boundary conditions exist?
- How should failures behave?

**Validation:**
- How will this be tested?
- Integration tests, unit tests, manual validation?
- What does a passing test prove?

Generate draft after block. Confirm before saving.

---

## Step 4 — Save Spec

Save to:

```
docs/specs/{feature-slug}.md
```

Rules:
- lowercase, kebab-case
- NEVER overwrite without confirmation
- If file exists: ask whether to overwrite or append
- Confirm path after saving:

```
Spec saved to docs/specs/feature-slug.md
```

---

## Step 5 — Loop

After saving, ask:

```
Which feature do you want to spec next?
(or type "done" to finish)
```

Repeat from Step 3 until user is done.

---

## Spec Format

```md
# Spec: [Feature Name]

> Status: draft
> Created: [YYYY-MM-DD]
> System Design: [path]

---

## Problem

...

---

## Scope

...

## Out of Scope

...

---

## Technical Design

### API Contracts

| Method | Endpoint | Request | Response | Errors |
|---|---|---|---|---|

### Data Model

...

### Dependencies

...

---

## Acceptance Criteria

- [ ] ...
- [ ] ...

---

## Edge Cases

- ...

---

## Validation

...
```

---

## General Rules

- Pre-fill from system design — reduce friction, avoid rework
- Push for concrete acceptance criteria — "works correctly" is not a criterion
- One feature per file
- kebab-case file names
- Never invent technical decisions — ask when unclear
- Scope must be explicit — ambiguity in scope = ambiguity in implementation
