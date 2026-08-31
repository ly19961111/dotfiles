# dotfiles

个人配置仓库，目前包含 Claude Code 自定义状态栏。

## claude/statusline.sh

自定义 Claude Code 状态栏（Dracula 配色），显示：

- **模型型号**（`◈ deepseek-v4-flash-vision-exp[1M]`）
- **上下文用量**（进度条 + 百分比 + `已用k/总k`）
- **缓存命中率 + 冷热状态**（`⚡ 91%`，数字红色 = 缓存热 / 蓝色 = 冷 / 灰色 `—` = 尚无数据）
- **思考强度**（`↯ max`，实时反映 `/effort` 改动；模型不支持时回退，仅开思考时显示 `↯ thinking`）
- 附加：费用、5h/7d 配额、目录、git 分支、worktree（有则显示）

**要求**：Claude Code ≥ 2.1.251（`prompt_cache` 字段）；**依赖** `jq`。

## 安装

新设备上执行：

```bash
git clone <repo-url> ~/dotfiles && cd ~/dotfiles && ./install.sh
```

脚本会自动：安装 `statusline.sh` 到 `~/.claude/scripts/`，并把
`statusLine` 配置**安全合并**进 `~/.claude/settings.json`（不覆盖其他配置）。
完成后重启 Claude Code 生效。

手动安装（等价，3 步）：

```bash
mkdir -p ~/.claude/scripts
cp claude/statusline.sh ~/.claude/scripts/statusline.sh
# 在 ~/.claude/settings.json 中加入:
# "statusLine": { "type": "command", "command": "~/.claude/scripts/statusline.sh" }
```

## 注意事项

⚠️ **不要把 `~/.claude/settings.json` 纳入本仓库**——里面含有 API token
（`ANTHROPIC_AUTH_TOKEN`）等敏感信息，只同步状态栏脚本和安装工具即可。
