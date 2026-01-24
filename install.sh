#!/bin/bash
set -e

CLAUDE_DIR="$HOME/.claude"
SCRIPT_NAME="statusline.sh"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Claude Code Statusline..."

# Create .claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Copy the statusline script
cp "$SCRIPT_DIR/$SCRIPT_NAME" "$CLAUDE_DIR/$SCRIPT_NAME"
chmod +x "$CLAUDE_DIR/$SCRIPT_NAME"

# Update settings.json
if [ -f "$SETTINGS_FILE" ]; then
    # Backup existing settings
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"

    # Check if jq is available
    if command -v jq &> /dev/null; then
        # Use jq to update settings
        jq '.statusLine = {"type": "command", "command": "~/.claude/statusline.sh"}' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp"
        mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    else
        echo "Warning: jq not found. Please manually add statusLine to $SETTINGS_FILE"
        echo 'Add: "statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}'
    fi
else
    # Create new settings file
    echo '{"statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}}' > "$SETTINGS_FILE"
fi

echo "Done! Restart Claude Code to see the statusline."
