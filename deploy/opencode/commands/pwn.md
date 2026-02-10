---
description: PWN binary exploitation for CTF and security research
agent: security
model: anthropic/claude-3-5-sonnet-20241022
subtask: true
---

Execute automated PWN binary exploitation for target $ARGUMENTS.

## Parameters
- $1: Binary file path
- $2: Optional remote target (ip:port)

## Execution Flow

### 1. Parse Parameters
Extract BINARY path and optional REMOTE target from $ARGUMENTS.

### 2. Binary Analysis

**Basic Check**:
```
# Quick PWN vulnerability check
quick_pwn_check(binary_path=BINARY)
```

Output information:
- File type and architecture
- Protection mechanisms (RELRO, Stack Canary, NX, PIE)
- Dangerous functions detection (gets, strcpy, sprintf, etc.)
- Exploitation difficulty assessment

### 3. Deep Analysis

```
# Automatic reverse engineering
auto_reverse_analyze(binary_path=BINARY)

# Radare2 detailed analysis
radare2_analyze_binary(binary_path=BINARY)
```

### 4. Automated Exploitation

**Local Exploitation**:
```
pwnpasi_auto_pwn(
    binary_path=BINARY,
    verbose=True
)
```

**Remote Exploitation** (if REMOTE provided):
```
# Parse ip:port
pwnpasi_auto_pwn(
    binary_path=BINARY,
    remote_ip=IP,
    remote_port=PORT,
    verbose=True
)
```

### 5. Comprehensive Attack

```
# Try multiple exploitation methods
pwn_comprehensive_attack(
    binary_path=BINARY,
    attack_methods=["pwnpasi_auto", "ret2libc", "rop_chain", "format_string"],
    remote_target=REMOTE if provided else "",
    timeout=300
)
```

### 6. CTF PWN Solver

```
# CTF-specific PWN solver
ctf_pwn_solver(
    target=BINARY,
    challenge_info={"category": "pwn", "binary_path": BINARY},
    time_limit="30min"
)
```

### 7. Output Results
- Vulnerability type and location
- Exploitation method
- Successfully obtained shell
- Reusable exploit scripts

## Examples
- /pwn /tmp/vuln_binary
- /pwn ./challenge 192.168.1.100:9999
- /pwn /ctf/pwn1
