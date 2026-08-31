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

## 安装（新设备）

本仓库是**私有**的，clone 前先在目标设备上完成 GitHub 认证（三选一）：

1. **gh CLI（推荐，全平台）**：`gh auth login --web`（拿 one-time code，浏览器授权）。
   gh 安装：macOS 用官方 zip 二进制；Windows `winget install GitHub.cli`；Linux `sudo apt install gh`。
2. **PAT**：GitHub 网页生成 fine-grained token，clone 时当作 https 密码输入。
3. **SSH**：生成 `~/.ssh/id_ed25519` 后把公钥加到 GitHub 账户，用 `git@github.com:...` 地址。

之后：

```bash
gh repo clone ly19961111/dotfiles ~/dotfiles && cd ~/dotfiles && ./install.sh
```

（手动的 `git clone https://github.com/...` 也可，但会提示用户名/密码——没有 token 就进不去。）

`install.sh` 会自动：安装 `statusline.sh` 到 `~/.claude/scripts/`，并把
`statusLine` 配置**安全合并**进 `~/.claude/settings.json`（不覆盖其他配置）。
它还会检查 `jq`，没装会提示（macOS `brew install jq` / Windows `winget install jqlang.jq`）。
完成后重启 Claude Code 生效。

### Windows 安装（全程在 Git Bash 里做）

Claude Code 在 Windows 上会**自动用 Git Bash** 运行状态栏命令，脚本无需任何改动。
前提装好三样：Git for Windows、gh、jq（PowerShell 里执行）：

```powershell
winget install Git.Git GitHub.cli jqlang.jq
```

然后打开 **Git Bash**，依次：

```bash
gh auth login --web        # 浏览器授权（私有仓库需要）
gh repo clone ly19961111/dotfiles ~/dotfiles
cd ~/dotfiles && ./install.sh
```

重启 Claude Code 生效。

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
