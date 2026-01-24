# Claude Code Statusline

A custom statusline for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that displays model info, context window usage, and token counts.

```
[Claude 3.5 Sonnet] ◉ 42% | 15K↓ 3K↑
```

- **Model name** in brackets
- **Context usage** with color indicator (green < 50%, yellow < 80%, red ≥ 80%)
- **Token counts** (input ↓ / output ↑)

## Requirements

- [jq](https://jqlang.org/) - JSON processor (required)

## Install

```bash
git clone https://github.com/IFAKA/claude-code-statusline.git
cd claude-code-statusline
./install.sh
```

Or one-liner:

```bash
curl -fsSL https://raw.githubusercontent.com/IFAKA/claude-code-statusline/main/install.sh | bash
```

Then restart Claude Code.

## Uninstall

```bash
./uninstall.sh
```

This completely removes the statusline script and cleans up settings - no traces left behind.

## Manual Installation

1. Copy `statusline.sh` to `~/.claude/statusline.sh`
2. Make it executable: `chmod +x ~/.claude/statusline.sh`
3. Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

## License

MIT
