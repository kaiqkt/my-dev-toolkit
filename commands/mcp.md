# Skill: mcp

Installs and configures MCP servers defined in `mcp/mcp.json` into the Claude Code settings.

## Usage

```
/mcp
/mcp list
```

## Behavior

### `list` subcommand

Read `mcp/mcp.json` from the project root and display the available MCP servers in a table:

| Name | Command | Description |
|------|---------|-------------|

### Default (install)

1. Read `mcp/mcp.json` from the repository root.
2. For each server, run:

```bash
claude mcp add <name> <command> <args...>
```

Example for the current servers:

```bash
# context7
claude mcp add context7 npx -y @upstash/context7-mcp@latest

# sequential-thinking
claude mcp add sequential-thinking npx -y @anthropic/sequential-thinking-mcp
```

3. If a server entry has `env` keys, append them with `-e KEY=VALUE` for each pair.
4. After installing, confirm which servers were added and instruct the user to restart Claude Code for the changes to take effect.

## Rules

- Never overwrite an existing MCP entry without asking the user first.
- If `mcp/mcp.json` does not exist, respond with: `No mcp.json found. Create mcp/mcp.json first.`
- Entries with `"<YOUR_GITHUB_TOKEN>"` or similar placeholders must be skipped with a warning asking the user to fill in the value before installing.
