#!/bin/bash
set -e

CLAUDE_DIR="$HOME/.claude"
SCRIPT_NAME="statusline.sh"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

echo "Uninstalling Claude Code Statusline..."

# Remove the statusline script
if [ -f "$CLAUDE_DIR/$SCRIPT_NAME" ]; then
    rm "$CLAUDE_DIR/$SCRIPT_NAME"
    echo "Removed $CLAUDE_DIR/$SCRIPT_NAME"
fi

# Remove statusLine from settings.json
if [ -f "$SETTINGS_FILE" ]; then
    if command -v jq &> /dev/null; then
        # Use jq to remove statusLine key
        jq 'del(.statusLine)' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp"
        mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
        echo "Removed statusLine from settings.json"

        # If settings.json is now empty (just {}), optionally remove it
        if [ "$(jq 'keys | length' "$SETTINGS_FILE")" -eq 0 ]; then
            rm "$SETTINGS_FILE"
            echo "Removed empty settings.json"
        fi
    else
        echo "Warning: jq not found. Please manually remove statusLine from $SETTINGS_FILE"
    fi
fi

# Remove backup file if it exists
if [ -f "$SETTINGS_FILE.backup" ]; then
    rm "$SETTINGS_FILE.backup"
    echo "Removed settings backup"
fi

echo "Done! Statusline has been completely removed."
