---

name: implement-from-spec
description: >
  Implements a feature from a spec file in docs/specs/. Reads the spec, decomposes
  into dependency-aware tasks, dispatches independent tasks to sub-agents in parallel,
  waits for completion, and validates against the spec's acceptance criteria. Follows
  TDD by default — writes tests first, then implements. Stack-agnostic: infers conventions
  from the project's CLAUDE.md. Use this skill whenever the user wants to implement a spec,
  build a feature from a spec, or execute a spec — even if they just say "implementa essa spec",
  "implement this spec", "execute spec", "build from spec", "executa a spec", "implementar feature",
  or similar natural language around spec-driven implementation.

---

# Skill: implement-from-spec

Implements a feature from a spec file. Decomposes into dependency-aware tasks,
dispatches sub-agents where possible, and validates the result against acceptance criteria.

---

## Usage

```
/implement-from-spec [path]
```

Examples:
- `/implement-from-spec docs/specs/auth-refresh-token.md`
- `/implement-from-spec` — lists available specs and asks which to use

---

## Behavior

- Read spec and project context before any action
- Decompose into tasks with explicit dependency graph
- Present plan and confirm before executing
- TDD-first: write failing test → implement → pass
- Stack-agnostic: infer conventions from CLAUDE.md, not hardcoded assumptions
- Dispatch independent tasks to sub-agents in parallel
- Wait for all sub-agents before validating
- Report gaps explicitly — never silently skip criteria

---

# Flow

---

## Step 1 — Load Spec & Project Context

If path provided:
- Read spec at given path

If no path provided:
- List files in `docs/specs/`
- If one: use it, inform user
- If multiple: present list, ask which to use
- If none: ask user to provide path

Also read:
- `CLAUDE.md` — extract: stack, test framework, lint/build commands, PR conventions, coding patterns
- If no `CLAUDE.md`: infer from project files (package.json, build.gradle, pom.xml, go.mod, etc.)

---

## Step 2 — Decompose into Tasks

Analyze the spec and break into implementation tasks.

For each task identify:
- What to implement
- Which acceptance criteria it covers
- Dependencies on other tasks (must complete first)
- Whether it can run in parallel with others

Present the dependency-aware execution plan:

```
Implementation plan for: [spec name]

Sequential:
  Task 1: [description] (no dependencies)
  Task 2: [description] (depends on Task 1)

Parallel after Task 2:
  Task 3a: [description]
  Task 3b: [description]

Sequential:
  Task 4: [description] (depends on Task 3a, 3b)

Confirm to proceed?
```

Do NOT proceed without user confirmation.

---

## Step 3 — Execute Tasks (TDD-first)

For each task, in dependency order:

### TDD cycle

1. Write a failing test that validates the relevant acceptance criterion from the spec
2. Implement the minimum code to make the test pass
3. Refactor if needed — do not break existing tests
4. Commit with conventional commit message referencing the spec

### Stack-agnostic approach

- Use test framework identified in Step 1
- Follow conventions from `CLAUDE.md`
- If no conventions found: use language-idiomatic defaults

### Parallel execution

- Tasks with no dependencies on each other → dispatch to sub-agents simultaneously
- Sub-agents receive: spec context, their specific task, project conventions
- Main skill waits for all parallel sub-agents before continuing

---

## Step 4 — Validate Against Spec

After all tasks complete, validate:

For each acceptance criterion in the spec:
- Is there a test covering it?
- Does that test pass?

Flag any criterion not covered by a test as a gap.

---

## Step 5 — Implementation Report

Generate and display:

```md
## Implementation Report: [spec name]

### Completed Tasks

- [x] Task 1 — [description]
- [x] Task 2 — [description]
...

### Acceptance Criteria Coverage

- [x] [Criterion] — covered by [test name]
- [ ] [Criterion] — NOT covered ⚠️

### Gaps

- [description of what is missing]

### Next Step

Run `/review-against-spec docs/specs/[spec-slug].md` to validate.
```

If gaps found:
- List explicitly
- Ask: "Do you want to resolve these gaps before finishing?"
- If yes: return to Step 3 for gap tasks
- If no: save report and close

---

## General Rules

- Never implement without reading the spec fully first
- Never skip the confirmation step before execution
- TDD is the default — write test before implementation
- Tests must map to acceptance criteria, not implementation details
- Do not add features not in the spec (YAGNI)
- Commit after each completed task — not at the end
- Report gaps honestly — never mark criteria as covered without a test
