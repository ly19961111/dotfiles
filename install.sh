#!/usr/bin/env bash
# Claude Code statusline 一键安装脚本（跨设备通用）
# 用法: git clone <repo-url> ~/dotfiles && cd ~/dotfiles && ./install.sh
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude/scripts"
TARGET="$CLAUDE_DIR/statusline.sh"
SETTINGS="$HOME/.claude/settings.json"
CMD="~/.claude/scripts/statusline.sh"

# 1. jq 检查
if ! command -v jq >/dev/null 2>&1; then
  echo "[!] 缺少 jq，请先安装:"
  echo "    macOS:    brew install jq"
  echo "    Debian:   sudo apt install jq"
  echo "    Windows:  winget install jqlang.jq"
  exit 1
fi

# 2. 安装状态栏脚本
mkdir -p "$CLAUDE_DIR"
cp "$HERE/claude/statusline.sh" "$TARGET"
chmod +x "$TARGET"
echo "[ok] 已安装 $TARGET"

# 3. 注册 statusLine（用 jq 安全合并，不覆盖已有其他配置）
mkdir -p "$HOME/.claude"
if [ -f "$SETTINGS" ]; then
  jq --arg cmd "$CMD" '.statusLine = {"type":"command","command":$cmd}' "$SETTINGS" > "$SETTINGS.tmp"
  mv "$SETTINGS.tmp" "$SETTINGS"
else
  printf '{"statusLine":{"type":"command","command":"%s"}}\n' "$CMD" > "$SETTINGS"
fi
echo "[ok] statusLine 已写入 $SETTINGS"

echo "[完成] 重启 Claude Code 生效"
