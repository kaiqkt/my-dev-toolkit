---

name: backlog
description: >
Creates and manages tasks in the project's local backlog following a hierarchical structure
of features and contexts. Use this skill whenever the user wants to create a task, list
backlog tasks, or update a task status — even if they just say "add to backlog", "adiciona no backlog",
"adicionar ao backlog", "cria uma task", "create task", "add task", "quero adicionar uma tarefa",
"coloca no backlog", "listar backlog", "list backlog", "show tasks", "mostra as tasks",
"atualiza status", "update status", or similar natural language around managing a backlog.
For bulk task generation from a system design document, use the system-design skill instead.
---

---

# Skill: backlog

Creates and manages tasks manually in the project's local backlog following a hierarchical structure of features and contexts.

> For bulk task generation from a system design document, use the `system-design` skill instead.

---

## Usage

Trigger with `/backlog` or natural language:

### Create a task

- `/backlog [user story or task description]`
- "add to backlog", "adiciona no backlog", "adicionar ao backlog"
- "cria uma task", "create task", "add task"
- "quero adicionar uma tarefa", "coloca no backlog"

### List tasks

- `/backlog list`
- "list backlog", "listar backlog"
- "show tasks", "mostra as tasks", "what's in the backlog"

### Update status

- `/backlog status [task-id or title] [new-status]`
- "atualiza status da task X para done", "update status of X to in-progress"
- "mark X as done", "marca X como done"

---

## Behavior

- If argument is `list` → run **List flow**
- If argument starts with `status` → run **Status flow**
- Otherwise → run **Create flow**

---

# 📊 List flow (INTELLIGENT)

Read all `tasks.md` files under `docs/backlog/`.

---

## 1. Aggregate data

- Count total tasks
- Count by status: `todo`, `in-progress`, `done`
- Group by Feature and Context
- Detect:
  - contexts with only `todo` (stalled)
  - contexts with more than 3 tasks `in-progress` (WIP overload)

---

## 2. Output summary

```markdown
## 📊 Backlog Summary

- Total tasks: X
- Todo: X
- In Progress: X
- Done: X

### 🚧 Work in Progress

- [feature/context]&#58; X tasks

### ⚠️ Attention Needed (Stalled)

- [feature/context]&#58; only todo tasks

### 🔥 WIP Overload

- [feature/context]&#58; too many tasks in progress

### ✅ Most Completed Feature

- [feature] (X% done)
```

---

## 3. Output grouped tasks

For each feature:

```markdown
## [Feature]

### [Context]

| ID  | Title | Status |
| --- | ----- | ------ |
```

### Rules

- Sort tasks by:
  1. `in-progress`
  2. `todo`
  3. `done`

- Prefer ID; fallback to title if missing
- Keep grouping by Feature → Context

---

## 4. Fallback

If no tasks found:

```
No tasks found.
```

---

# 🔄 Status flow (ROBUST)

Updates the status of an existing task.

---

## Valid statuses

- `todo`
- `in-progress`
- `done`

---

## Steps

1. Search all `tasks.md` under `docs/backlog/` for:
   - Matching `ID` (preferred)
   - Or `## [Task Title]` (case-insensitive, partial match)

2. If no match:

```
Task not found.
```

3. If multiple matches:

- List matches with Feature/Context path
- Ask user to clarify

4. Update task block:

```markdown
**Status:** `new-status`
**Updated at:** YYYY-MM-DD
```

5. Update `docs/backlog/index.md`:

- Recount tasks for the affected context
- Update corresponding row in `Overview`

---

# ➕ Create flow (STRUCTURED)

## 1. Collect information

Ask for missing fields:

- Feature (e.g. `backend`, `frontend`, `infra`)
- Context (e.g. `auth`, `payments/pix`)
- Task title
- Description
- User Story

### Rules

- If user provides a user story → derive title and description
- Do NOT ask for already provided info

---

## 2. Generate Task ID

Format:

```
[FEATURE-CONTEXT-XXX]
```

### Examples

- `AUTH-001`
- `PAYMENTS-PIX-002`

### Rules

- Uppercase
- Increment per context
- Zero-padded (001, 002, ...)

---

## 3. Directory structure

```
docs/backlog/
  index.md
  {feature}/
    {context}/
      tasks.md
```

### Examples

- `docs/backlog/backend/auth/tasks.md`
- `docs/backlog/backend/payments/pix/tasks.md`

---

## 4. Task format

```markdown
## [TASK-ID] Task Title

**Status:** `todo`
**Created at:** YYYY-MM-DD
**Updated at:** YYYY-MM-DD
**Description:** [description]
**User Story:** As a [user], I want [action] so that [benefit].
```

---

## 5. File rules

### If `tasks.md` does not exist

```markdown
# [Context Name]

> Feature: [feature name]
```

Then append task.

### If exists

- Append task only
- Never overwrite existing tasks

---

## 6. Update index.md

### If not exists

```markdown
# Backlog

> General index of project features and tasks.

## Overview

| Feature | Context | Todo | In Progress | Done |
| ------- | ------- | ---- | ----------- | ---- |

## Features
```

---

### Update logic

1. Count tasks in the context
2. Update or insert row in Overview table

### Ensure feature section exists

```markdown
### [feature]

- [context](feature/context/tasks.md)
```

---

# 📏 General Rules

- Never overwrite tasks
- Always append
- Always update `index.md`
- Use kebab-case for directories
- Use uppercase IDs
- Prefer ID over title for operations
- Keep user story as provided (do not invent details)

---

# 💡 Notes

- This backlog is **code-native** and versioned
- Designed to evolve into:
  - CLI (`backlog add`, `backlog list`)
  - Backend API
  - Internal UI

- Optimized for low friction and high visibility inside the repo

---
