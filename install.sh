#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_SRC="$SCRIPT_DIR/commands"
COMMANDS_DST="$HOME/.claude/commands"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

echo "Installing my-dev-toolkit..."

# Install slash commands
mkdir -p "$COMMANDS_DST"
for file in "$COMMANDS_SRC"/*.md; do
  [ -e "$file" ] || continue
  name="$(basename "$file")"
  cp "$file" "$COMMANDS_DST/$name"
  echo "  [commands] $name"
done

# Install skills
if [ -d "$SKILLS_SRC" ]; then
  mkdir -p "$SKILLS_DST"
  for skill_dir in "$SKILLS_SRC"/*/; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    mkdir -p "$SKILLS_DST/$name"
    cp "$skill_dir/SKILL.md" "$SKILLS_DST/$name/SKILL.md"
    echo "  [skills] $name"
  done
fi

# Install MCP servers
MCP_JSON="$(cd "$(dirname "$0")/mcp" && pwd)/mcp.json"

if [ -f "$MCP_JSON" ] && command -v claude &>/dev/null; then
  echo "Installing MCP servers..."
  servers=$(python3 -c "
import json, sys
data = json.load(open('$MCP_JSON'))
for name, cfg in data['mcpServers'].items():
    args = ' '.join(cfg['args'])
    print(f\"{name} {cfg['command']} {args}\")
")
  while IFS= read -r line; do
    name=$(echo "$line" | awk '{print $1}')
    cmd=$(echo "$line" | awk '{print $2}')
    args=$(echo "$line" | cut -d' ' -f3-)
    claude mcp add "$name" "$cmd" $args 2>/dev/null && echo "  [mcp] $name" || echo "  [mcp] $name (already exists, skipped)"
  done <<< "$servers"
else
  [ ! -f "$MCP_JSON" ] && echo "  [mcp] mcp.json not found, skipping"
  ! command -v claude &>/dev/null && echo "  [mcp] claude CLI not found, skipping"
fi

echo ""
echo "Done. Restart Claude Code to apply changes."
echo ""
