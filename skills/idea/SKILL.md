---

name: idea
description: >
  Develops and structures ideas collaboratively through a guided linear flow:
  concept, problem, audience, product vision, usage storyboard, competitor research,
  and essence. Use this skill whenever the user wants to develop, explore, validate,
  or document an idea — even if they just say "tenho uma ideia", "quero desenvolver uma ideia",
  "me ajuda com essa ideia", "develop this idea", "I have an idea", "let's explore this idea",
  "quero estruturar uma ideia", "vamos pensar nessa ideia", or similar natural language
  around ideation and product thinking.

---

# Skill: idea

Develops and structures ideas through a guided linear conversation. Works for both vague ideas and already-formed concepts.

---

## Usage

Trigger with `/idea` or natural language:

- `/idea [description]`
- "tenho uma ideia", "quero desenvolver uma ideia"
- "I have an idea", "let's explore this idea"
- "me ajuda com essa ideia", "quero estruturar uma ideia"

---

## Behavior

- Follow sections in order
- Do NOT skip sections
- Do NOT move to the next section without confirmation
- Ask questions in small batches — avoid overwhelming
- Challenge vague answers with follow-up questions
- Extract clarity before moving forward
- If the user already has content for a section, accept it and move on

---

## Philosophy

- Clarity before features
- Problem before technology
- Essence before scale
- Refine before build

---

# Flow

Walk through the following sections step-by-step.

---

## 1. Concept

Understand what the idea is.

Ask:
- What is it?
- How does it work?
- What is the core proposition?

Target format:
> A __________ that allows __________.

Challenge vague descriptions. Push for a single clear sentence.

---

## 2. Problem

Understand the pain, difficulty, or desire the idea addresses.

Ask:
- What is currently annoying, slow, or confusing?
- What do people do manually that could be simpler?
- Is this solving a real problem or a desired experience?

Distinguish between pain-driven and desire-driven ideas. Both are valid — but they require different approaches.

---

## 3. Audience

Define who this is for.

Ask:
- Who would use this immediately?
- Who would feel the value most?
- Who is explicitly NOT the audience?

Push for specificity. "Everyone" is not an audience.

---

## 4. Product Vision

Describe the features and experience.

### Features

Ask:
- What are the core features?
- What is essential vs. nice-to-have?
- If you had 1 week, what would you build?

### Experience & UI

Do NOT generate UI layouts or invent visual references.

Instead, ask the user to provide:
- References to products with similar UI/UX (screenshots, URLs, app names)
- Description of the desired experience in their own words
- Any sketches, wireframes, or mockups they already have

Only after receiving user input, summarize what was described.

If the user has no references yet, prompt:
> "Do you have any visual references — apps, screenshots, or links — that show the kind of experience you want? Even rough ideas help."

Apply YAGNI ruthlessly. Challenge feature bloat.

---

## 5. Usage Storyboard

Simulate real usage.

Guide the user through a concrete scenario:

```
1. User wants __________
2. They open the product
3. They do __________
4. The system __________
5. Final result: __________
```

Push for specific, realistic scenarios — not abstract flows.

---

## 6. Competitor Research

Research similar products.

Spawn the `competitor-research` agent with the idea description gathered so far.

The agent will:
- Search for similar products using WebSearch and MCP fetch
- Return a comparison table

Expected output from agent:

| Product | What it does | Audience | Differentiator | Gap |
|---|---|---|---|---|

After receiving the table, discuss:
- What do competitors do well?
- What do they do poorly?
- What differentiates this idea?
- Are there market gaps to exploit?

---

## 7. Essence

Summarize the idea in one sentence.

Target format:
> It's basically a __________ focused on __________.

This sentence should survive simplification. If it doesn't make sense simplified, the idea needs more refinement.

---

## Draft Output After Each Section

After each section, generate:

```md
## [Section Name] (Draft)

### Summary

- Key points captured

### Open Questions

- What still needs validation
```

Do NOT continue until confirmed.

---

## Final Output

After all sections are completed, consolidate into:

```md
# Idea: [Name]

> Status: draft
> Created: [YYYY-MM-DD]

---

## Concept

...

---

## Problem

...

---

## Audience

...

---

## Product Vision

### Features

...

### Experience

...

---

## Usage Storyboard

...

---

## Competitor Research

| Product | What it does | Audience | Differentiator | Gap |
|---|---|---|---|---|

### Differentiators

...

### Gaps

...

---

## Essence

> It's basically a __________ focused on __________.

---

## Expected Result

- [ ] Clarity on what this is
- [ ] Defined audience
- [ ] Perceived value
- [ ] Main flow mapped
- [ ] Differentiator identified
- [ ] Obvious next step
```

---

## Save

After generating the final output, save to:

```
/docs/idea/{idea-slug}.md
```

Rules:
- lowercase
- kebab-case
- example: `social-feed.md`, `url-shortener.md`

### Save Rules

- NEVER overwrite without confirmation
- If file exists: ask whether to overwrite or append
- Confirm path after saving:

```
Idea saved to /docs/idea/idea-slug.md
```
