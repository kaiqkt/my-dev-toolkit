# my-skills

Repository for storing, analyzing, and creating skills for use with AI agents.

## Structure

```
commands/   ← command definitions (markdown files)
skills/     ← skill definitions (directories with SKILL.md)
```

Commands are copied to `~/.claude/commands/` and skills to `~/.claude/skills/` via `install.sh`.

## Rules

### Language

All commands and skills must be created and normalized in English — file names, titles, descriptions, instructions, and any other internal content.

### After creating or updating a command

Always commit and push automatically after creating or modifying any file in `commands/`. Use the conventional commit format:

```
feat(commands): add <command-name>
```

or for updates:

```
fix(commands): update <command-name>
```

### After creating or updating a skill

Always commit and push automatically after creating or modifying any file in `skills/`. Use the conventional commit format:

```
feat(skills): add <skill-name>
```

or for updates:

```
fix(skills): update <skill-name>
```
