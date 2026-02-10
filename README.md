# KaliSec-MCP + OpenCode Skill 一键部署包

<p align="center">
  <img src="https://img.shields.io/badge/Tools-183-blue" alt="Tools">
  <img src="https://img.shields.io/badge/Skills-58K%20Lines-green" alt="Skills">
  <img src="https://img.shields.io/badge/Commands-6-orange" alt="Commands">
  <img src="https://img.shields.io/badge/Platform-Kali%20Linux-red" alt="Platform">
  <img src="https://img.shields.io/badge/Docker-Ready-blue" alt="Docker">
</p>

> **AI 驱动的智能安全测试框架**
>
> 将 183 个 Kali Linux 安全工具与 Claude AI 深度集成，实现智能化渗透测试和 CTF 解题。

---

## ✨ 特性

- 🔧 **183 个安全工具** - 涵盖信息收集、Web测试、密码攻击、漏洞利用、PWN/逆向
- 🧠 **58,554 行知识库** - 五层架构的完整安全测试知识体系
- ⚡ **6 个快捷命令** - 一键启动复杂攻击流程
- 🎯 **智能决策树** - 自动根据工具输出选择下一步行动
- 🏆 **CTF 专用模式** - 自动 Flag 检测和提取
- 📊 **经验学习** - 记录攻击历史，持续优化策略
- 🐳 **Docker 支持** - 一键部署完整的 Kali Linux 环境

---

## 📦 一键安装

### 方法 1: 使用 Docker 部署（推荐）

```bash
# 克隆仓库
git clone https://github.com/xiaodaoi/KaliSec-MCP.git
cd KaliSec-MCP

# 使用 Docker Compose 启动
docker-compose up -d

# 查看日志
docker-compose logs -f kali-mcp-server
```

Docker 容器将自动：
- 安装 Kali Linux Everything（包含所有安全工具）
- 配置 MCP 服务器
- 部署 OpenCode Skill 知识库
- 启动 SSE 服务器（端口 8765）

### 方法 2: 使用安装脚本（Kali Linux 本地安装）

```bash
# 克隆仓库
git clone https://github.com/xiaodaoi/KaliSec-MCP.git
cd KaliSec-MCP/deploy

# 运行安装脚本
chmod +x install.sh
./install.sh
```

### 方法 3: 手动安装

```bash
# 1. 安装 Python 依赖
pip3 install mcp pydantic aiohttp aiofiles

# 2. 复制 MCP 服务器
mkdir -p ~/.local/share/kali-mcp
cp mcp_server.py ~/.local/share/kali-mcp/

# 3. 复制 OpenCode 配置
cp -r deploy/opencode/* ~/.config/opencode/

# 4. 配置 MCP 服务器（见下方配置说明）
```

---

## ⚙️ 配置

### 📡 两种运行模式

#### 模式一：本地模式 (stdio) - 默认

用于 **Claude Desktop** 或 **Claude Code** 本地连接，无需网络端口。

```bash
# 直接运行（默认 stdio 模式）
python3 mcp_server.py
```

**OpenCode 配置** (`~/.config/opencode/opencode.json`):
```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "kalisec-mcp": {
      "type": "local",
      "command": ["python3", "/opt/kali-mcp/mcp_server.py"],
      "enabled": true,
      "environment": {
        "PYTHONUNBUFFERED": "1"
      }
    }
  }
}
```

#### 模式二：远程模式 (SSE) - 外部 AI 连接

用于 **外部 AI 系统** 通过 HTTP 网络连接。

```bash
# 启动 SSE 服务器（默认端口 8765）
python3 mcp_server.py --transport=sse --port=8765

# 指定监听地址和端口
python3 mcp_server.py --transport=sse --host=0.0.0.0 --port=9000
```

**连接信息**:
| 端点 | 地址 |
|------|------|
| SSE 端点 | `http://<kali-ip>:8765/sse` |
| 消息端点 | `http://<kali-ip>:8765/messages` |

**外部 AI 配置示例**:
```json
{
  "mcpServers": {
    "kalisec-mcp": {
      "url": "http://192.168.1.100:8765/sse",
      "transport": "sse"
    }
  }
}
```

### 🔧 命令行参数

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `--transport` | `stdio` | 传输模式: `stdio` 或 `sse` |
| `--host` | `0.0.0.0` | SSE 监听地址 |
| `--port` | `8765` | SSE 监听端口 |
| `--debug` | - | 启用调试日志 |

### 🌐 防火墙配置（SSE 模式）

```bash
# Kali Linux / Debian
sudo ufw allow 8765/tcp

# 或使用 iptables
sudo iptables -A INPUT -p tcp --dport 8765 -j ACCEPT
```

### OpenCode MCP 配置

在 `~/.config/opencode/opencode.json` 中添加:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "kalisec-mcp": {
      "type": "local",
      "command": ["python3", "/opt/kali-mcp/mcp_server.py"],
      "enabled": true,
      "environment": {
        "PYTHONUNBUFFERED": "1"
      }
    }
  }
}
```

### 验证安装

重启 Claude Code 后，运行:

```
server_health()
```

如果返回服务器状态信息，说明安装成功。

---

## 🚀 快速开始

### 快捷命令

| 命令 | 用途 | 示例 |
|------|------|------|
| `/ctf TARGET [CATEGORY]` | CTF 快速解题 | `/ctf http://challenge.com web` |
| `/pentest TARGET [MODE]` | 渗透测试 | `/pentest 192.168.1.100 comprehensive` |
| `/apt TARGET` | APT 攻击模拟 | `/apt target.com` |
| `/vuln TARGET [TYPE]` | 漏洞评估 | `/vuln http://site.com sql` |
| `/recon TARGET [DEPTH]` | 信息收集 | `/recon example.com deep` |
| `/pwn BINARY [REMOTE]` | PWN 攻击 | `/pwn ./vuln 192.168.1.1:9999` |

### 直接使用 MCP 工具

```python
# CTF 一键解题
intelligent_ctf_solve(target="http://ctf.example.com", mode="aggressive")

# 全面 Web 安全扫描
comprehensive_web_security_scan(target="http://target.com")

# 智能渗透测试
intelligent_penetration_testing(target="192.168.1.100", methodology="owasp")

# PWN 自动化利用
pwnpasi_auto_pwn(binary_path="/tmp/vuln", remote_ip="192.168.1.1", remote_port=9999)
```

---

## 📚 知识库架构

```
┌─────────────────────────────────────────────────────────────────┐
│  L5: 高级技巧层 - 绕过技术、自动化脚本、AI辅助策略               │
├─────────────────────────────────────────────────────────────────┤
│  L4: 方法论层 - MITRE ATT&CK、OWASP、PTES、CTF方法论            │
├─────────────────────────────────────────────────────────────────┤
│  L3: 场景剧本层 - 50+ 实战场景的完整攻击流程                     │
├─────────────────────────────────────────────────────────────────┤
│  L2: 工具详解层 - 183 个工具的三段式深度解析                     │
├─────────────────────────────────────────────────────────────────┤
│  L1: 快速参考层 - CTF 速查表、渗透测试速查表、紧急决策树         │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔧 工具分类

### 信息收集 (25 个)
`nmap_scan`, `masscan_fast_scan`, `subfinder_scan`, `amass_enum`, `theharvester_osint`, `whatweb_scan`, `httpx_probe`, ...

### Web 应用测试 (35 个)
`gobuster_scan`, `sqlmap_scan`, `nuclei_scan`, `nikto_scan`, `wpscan_scan`, `intelligent_xss_payloads`, ...

### 密码攻击 (15 个)
`hydra_attack`, `john_crack`, `hashcat_crack`, `medusa_bruteforce`, `aircrack_attack`, ...

### 漏洞利用 (20 个)
`metasploit_run`, `searchsploit_search`, `apt_comprehensive_attack`, `intelligent_apt_campaign`, ...

### PWN 与逆向 (20 个)
`quick_pwn_check`, `pwnpasi_auto_pwn`, `auto_reverse_analyze`, `radare2_analyze_binary`, ...

### 智能化工具 (68 个)
`intelligent_ctf_solve`, `ai_intelligent_target_analysis`, `ai_adaptive_attack_execution`, ...

---

## 📁 目录结构

```
KaliSec-MCP/
├── mcp_server.py              # MCP 服务器主文件 (10,630 行)
├── deploy/                    # 部署包
│   ├── install.sh             # 一键安装脚本
│   ├── uninstall.sh           # 卸载脚本
│   └── opencode/              # OpenCode 配置文件
│       ├── commands/          # 快捷命令
│       │   ├── ctf.md
│       │   ├── pentest.md
│       │   ├── apt.md
│       │   ├── vuln.md
│       │   ├── recon.md
│       │   └── pwn.md
│       └── skills/            # Skill 知识库
│           └── kali-security/
│               ├── SKILL.md        # 完整知识库 (58,554 行)
│               ├── CLAUDE.md       # 全局指令文件
│               ├── kali-index.json # 工具索引
│               └── attack-history.json # 学习数据
├── Dockerfile                 # Docker 镜像构建文件
├── docker-compose.yml         # Docker Compose 配置
├── .dockerignore              # Docker 忽略文件
├── requirements.txt           # Python 依赖
└── README.md                  # 项目说明
```

---

## 🐳 Docker 部署

### 快速启动

```bash
# 构建并启动容器
docker-compose up -d

# 查看日志
docker-compose logs -f kali-mcp-server

# 进入容器
docker-compose exec kali-mcp-server bash
```

### 容器特性

- **基础镜像**: `kalilinux/kali-rolling:latest`
- **安装内容**: Kali Linux Everything（完整工具集）
- **特权模式**: 支持需要 root 权限的安全工具
- **网络能力**: 支持原始套接字和包捕获
- **健康检查**: 自动监控服务状态

### 端口映射

| 容器端口 | 主机端口 | 用途 |
|----------|----------|------|
| 8765 | 8765 | SSE 服务器 |

### 数据持久化

```yaml
volumes:
  - ./data:/opt/kali-mcp/data
```

将 `./data` 目录挂载到容器中，用于保存攻击历史和配置。

---

## 🔄 卸载

### Docker 部署卸载

```bash
# 停止并删除容器
docker-compose down

# 删除镜像
docker rmi kali-mcp-kali-everything
```

### 本地安装卸载

```bash
cd deploy
chmod +x uninstall.sh
./uninstall.sh
```

---

## ⚠️ 法律声明

**本工具仅用于以下合法用途:**

- ✅ 授权的渗透测试
- ✅ CTF 竞赛和安全训练
- ✅ 安全研究和漏洞分析
- ✅ 防御性安全评估

**严禁用于:**

- ❌ 未经授权的攻击
- ❌ 恶意目的
- ❌ 任何违法活动

**使用者需对自己的行为承担全部法律责任。**

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request!

---

## 📄 许可证

MIT License

---

## 🙏 致谢

- [Claude Code](https://claude.ai/claude-code) - Anthropic
- [Kali Linux](https://www.kali.org/) - Offensive Security
- [MCP Protocol](https://modelcontextprotocol.io/) - Model Context Protocol

---

<p align="center">
  <b>🔒 安全测试，从智能开始 🔒</b>
</p>
