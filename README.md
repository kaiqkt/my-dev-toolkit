# my-dev-toolkit

Personal Claude Code setup — slash commands, skills, agents, and MCP servers for faster and more consistent AI-assisted development.

## What's Inside

| Component | Count |
|-----------|-------|
| Commands | 1 |
| Skills | 7 |
| Agents | 1 |
| MCP Servers | 2 |

## Install

```bash
git clone https://github.com/kaiqkt/my-dev-toolkit.git ~/my-dev-toolkit
cd ~/my-dev-toolkit
chmod +x install.sh
./install.sh
```

To install MCP servers, open Claude Code and run:

```
/mcp
```

## Commands

| Command | Description |
|---------|-------------|
| `/claude-init` | Generate a `CLAUDE.md` for any project |

## Skills

| Skill | Description |
|-------|-------------|
| `/conventional-commit` | Generate conventional commit messages following the v1.0.0 spec |
| `/think` | Develop and structure ideas through a guided flow: concept → problem → audience → vision → storyboard → competitor research → essence |
| `/implement-from-spec` | Implement a feature from a spec file in `docs/specs/` — decomposes into tasks, runs in parallel, validates against acceptance criteria |
| `/review-against-spec` | Review implementation against a spec file — reports each acceptance criterion as covered, partial, or missing |
| `/sdd` | Create per-feature Software Design Documents from a system design output |
| `/spring-boot-integration-testing` | Write and review Spring Boot integration tests in Kotlin (real Spring context, Testcontainers, MockServer) |
| `/system-design` | Guided system design discussion — walks through requirements, architecture, data design, API design, scaling, and reliability |

## Agents

| Agent | Description |
|-------|-------------|
| `competitor-research` | Research similar and competing products — returns a structured comparison table with products, audiences, differentiators, and gaps |

## MCP Servers

| Name | Package | Description |
|------|---------|-------------|
| `context7` | `@upstash/context7-mcp` | Library docs lookup — latest docs instead of stale training data |
| `sequential-thinking` | `@anthropic/sequential-thinking-mcp` | Step-by-step reasoning for system design and architecture |

## License

[MIT](LICENSE)
