# Kali Linux Everything 完整版：包含 193 个 MCP 安全工具
FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# 更新证书、安装基础工具、升级系统并安装 Kali Everything
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ca-certificates && \
    apt-get update && apt-get install -y \
    python3 python3-pip python3-venv git curl wget vim nano \
    net-tools iputils-ping telnet && \
    apt update -y && apt full-upgrade -y && \
    apt install -y --no-install-recommends kali-linux-everything && \
    apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/kali-mcp

# 复制代码文件
COPY mcp_server.py .
COPY requirements.txt .

# Python 依赖
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

# 创建配置目录和文件
RUN mkdir -p /root/.config/opencode/skills/kali-security

# 复制 deploy/opencode/skills/kali-security/ 文件夹下面的文件到配置目录
COPY deploy/opencode/skills/kali-security/SKILL.md /root/.config/opencode/skills/kali-security/
COPY deploy/opencode/skills/kali-security/attack-history.json /root/.config/opencode/skills/kali-security/
COPY deploy/opencode/skills/kali-security/kali-index.json /root/.config/opencode/skills/kali-security/

# 复制 commands 文件夹到 opencode 配置目录
COPY deploy/opencode/commands /root/.config/opencode/commands/

# 复制并优化 CLAUDE.md 到 opencode 配置目录
COPY deploy/opencode/skills/kali-security/CLAUDE.md /root/.config/opencode/skills/kali-security/

# 创建 OpenCode 配置文件
RUN cat > /root/.config/opencode/opencode.json << 'EOF'
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
EOF

# 安装 OpenCode
RUN curl -fsSL https://opencode.ai/install | bash

EXPOSE 8765

# 默认命令
CMD ["python3", "mcp_server.py", "--transport=sse", "--host=0.0.0.0", "--port=8765"]

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8765/ || exit 1