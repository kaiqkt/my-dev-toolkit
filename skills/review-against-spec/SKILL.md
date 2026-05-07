---

name: review-against-spec
description: >
  Reviews the current implementation against a spec file in docs/specs/. Reads the spec,
  inspects the codebase, and reports the status of each acceptance criterion — covered,
  partial, or missing. Surfaces gaps, ambiguities, and deviations from scope. Use this
  skill whenever the user wants to verify implementation against a spec, check if a feature
  is done, audit a spec, or validate before opening a PR — even if they just say "revisa
  contra spec", "review against spec", "valida implementação", "checar spec", "está completo?",
  "verify implementation", "check spec coverage", or similar natural language around
  spec-driven validation.

---

# Skill: review-against-spec

Reviews the current implementation against a spec file. Reports the status of each
acceptance criterion and surfaces gaps before merging or shipping.

---

## Usage

```
/review-against-spec [path]
```

Examples:
- `/review-against-spec docs/specs/auth-refresh-token.md`
- `/review-against-spec` — lists available specs and asks which to review

---

## Behavior

- Read spec fully before inspecting code
- Map each acceptance criterion to evidence in the codebase (tests, implementation)
- Be explicit: covered, partial, or missing — no vague conclusions
- Surface out-of-scope additions as warnings
- Do not suggest fixes — report only. User decides what to do.

---

# Flow

---

## Step 1 — Load Spec

If path provided:
- Read spec at given path

If no path provided:
- List files in `docs/specs/`
- If one: use it, inform user
- If multiple: present list, ask which to review
- If none: ask user to provide path

Extract from spec:
- Acceptance criteria (the checklist)
- Scope definition
- Out of scope definition
- Technical design expectations (API contracts, data model)

---

## Step 2 — Inspect Implementation

Search the codebase for evidence related to each criterion:

- Tests: find tests that exercise the criterion
- Implementation: find code that fulfills the criterion
- API: verify endpoints match contracts defined in spec
- Data model: verify schema matches spec definition

Use grep, file reads, and directory exploration as needed.

---

## Step 3 — Map Criteria to Evidence

For each acceptance criterion, determine status:

| Status | Meaning |
|---|---|
| ✅ Covered | Test exists and passes, implementation present |
| ⚠️ Partial | Implementation exists but test missing or incomplete |
| ❌ Missing | No implementation or test found |

Also check:
- **Scope drift**: code added that is not in the spec scope
- **Contract mismatch**: API or data model deviates from spec
- **Edge cases**: spec lists edge cases — are they handled?

---

## Step 4 — Generate Review Report

```md
## Spec Review: [spec name]

> Spec: [path]
> Reviewed: [YYYY-MM-DD]

---

### Acceptance Criteria

| Criterion | Status | Evidence |
|---|---|---|
| [criterion 1] | ✅ Covered | [test name / file:line] |
| [criterion 2] | ⚠️ Partial | [what exists / what's missing] |
| [criterion 3] | ❌ Missing | — |

---

### Scope

- **In scope, implemented:** ...
- **In scope, missing:** ...
- **Out of scope additions:** ... ⚠️

---

### Contract Compliance

- API: [matches / deviates — details]
- Data model: [matches / deviates — details]

---

### Edge Cases

- [edge case from spec]: [handled / not handled]

---

### Summary

- Total criteria: X
- Covered: X
- Partial: X
- Missing: X

### Verdict

[READY / NOT READY] — [one sentence reason]

---

### Recommended Next Steps

- ...
```

---

## General Rules

- Report only — do not implement or suggest code changes
- Evidence must be concrete: file path and line number where possible
- "Covered" requires both implementation AND test — not one alone
- Scope drift is always flagged, never ignored
- Verdict must be binary: READY or NOT READY
