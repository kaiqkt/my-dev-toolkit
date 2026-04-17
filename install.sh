#!/usr/bin/env bash
set -euo pipefail

COMMANDS_SRC="$(cd "$(dirname "$0")/commands" && pwd)"
COMMANDS_DST="$HOME/.claude/commands"

echo "Installing my-dev-toolkit..."

# Install slash commands
mkdir -p "$COMMANDS_DST"
for file in "$COMMANDS_SRC"/*.md; do
  name="$(basename "$file")"
  cp "$file" "$COMMANDS_DST/$name"
  echo "  [commands] $name"
done

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
