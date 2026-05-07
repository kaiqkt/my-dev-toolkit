# my-skills

Repository for storing, analyzing, and creating skills for use with AI agents.

## Structure

```
commands/   ← command definitions (markdown files)
skills/     ← skill definitions (directories with SKILL.md)
agents/     ← agent definitions (markdown files with frontmatter)
```

Commands are copied to `~/.claude/commands/`, skills to `~/.claude/skills/`, and agents to `~/.claude/agents/` via `install.sh`.

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

### After creating or updating an agent

Always commit and push automatically after creating or modifying any file in `agents/`. Use the conventional commit format:

```
feat(agents): add <agent-name>
```

or for updates:

```
fix(agents): update <agent-name>
```
