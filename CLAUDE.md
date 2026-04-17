# my-skills

Repository for storing, analyzing, and creating skills for use with AI agents.

## Structure

```
commands/   ← command definitions (markdown files)
```

Commands are copied to `~/.claude/commands/` for global use in Claude Code.

## Rules

### Language

All commands must be created and normalized in English — file names, titles, descriptions, instructions, and any other internal content.

### After creating or updating a command

Always commit and push automatically after creating or modifying any file in `commands/`. Use the conventional commit format:

```
feat(commands): add <command-name>
```

or for updates:

```
fix(commands): update <command-name>
```
