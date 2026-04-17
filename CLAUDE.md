# my-skills

Repository for storing, analyzing, and creating skills for use with AI agents.

## Structure

```
skills/   ← skill definitions (markdown files)
```

Skills are copied to `~/.claude/commands/` for global use in Claude Code.

## Rules

### Language

All skills must be created and normalized in English — file names, titles, descriptions, instructions, and any other internal content.

### After creating or updating a skill

Always commit and push automatically after creating or modifying any file in `skills/`. Use the conventional commit format:

```
feat(skills): add <skill-name>
```

or for updates:

```
fix(skills): update <skill-name>
```
