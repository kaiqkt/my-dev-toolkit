---
name: conventional-commit
description: >
  Generates a conventional commit message following the Conventional Commits v1.0.0 spec
  (https://www.conventionalcommits.org). Use this skill whenever the user wants to commit
  code and wants help writing the message — even if they just say "commit", "make a commit",
  "quero commitar", "me ajuda com o commit", or similar. Analyze the staged changes and
  produce a properly formatted message. Always invoke this before running git commit.
---

# Conventional Commit

## Goal

Analyze the staged git changes and produce a commit message that strictly follows the
Conventional Commits v1.0.0 specification. Then offer it to the user for confirmation
before committing.

## Commit format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Rules

- Subject line: `type(scope): description` — max 72 characters
- One blank line between subject and body (if body exists)
- One blank line between body and footers (if footers exist)
- Description: imperative mood, lowercase, no period at the end
- Body: free-form, explain *what* and *why*, not *how*
- Footers: `Token: value` format; multi-word tokens use hyphens (e.g. `Reviewed-by`)

### Types

| Type | Use when |
|------|----------|
| `feat` | New feature added (MINOR in SemVer) |
| `fix` | Bug fix (PATCH in SemVer) |
| `docs` | Documentation only |
| `style` | Formatting, whitespace — no logic change |
| `refactor` | Code restructure without feature or fix |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `chore` | Tooling, dependencies, config — no production code |
| `build` | Build system or external dependency changes |
| `ci` | CI/CD configuration changes |
| `revert` | Reverts a previous commit |

### Breaking changes

Two equivalent notations — use whichever fits better:

1. `feat!: description` or `feat(scope)!:` — append `!` before the colon
2. Footer: `BREAKING CHANGE: explanation of what broke and how to migrate`

Use both when the change needs migration instructions in the footer.

## Step-by-step

1. Run `git diff --staged` to inspect all staged changes
2. If nothing is staged, inform the user and stop
3. Identify:
   - The primary **type** based on what changed
   - An optional **scope** if the change is isolated to a module, package, or domain
   - Whether any **breaking changes** exist (removed APIs, changed signatures, incompatible behavior)
4. Draft the commit message following the format above
5. Present it clearly to the user for review
6. If the user approves (or says "yes", "ok", "pode", "sim"), run:
   ```
   git commit -m "$(cat <<'EOF'
   <message>
   EOF
   )"
   ```
7. If the user wants changes, revise and ask again

## Examples

**Simple fix:**
```
fix(auth): prevent token expiry on concurrent requests
```

**New feature with scope:**
```
feat(payments): add Pix payment method
```

**Breaking change with footer:**
```
feat(api)!: remove deprecated v1 endpoints

BREAKING CHANGE: /api/v1/* routes have been removed.
Migrate to /api/v2/* equivalents documented in MIGRATION.md.
```

**Chore:**
```
chore(deps): upgrade spring-boot to 3.2.4
```

**Multiple concerns — pick the dominant one:**
If a PR touches many things, pick the type that best represents the primary intent.
Mention secondary changes in the body.
