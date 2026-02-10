---
description: CTF quick solve for penetration testing and security challenges
agent: security
model: anthropic/claude-3-5-sonnet-20241022
subtask: true
---

Execute CTF (Capture The Flag) challenge solving for target $ARGUMENTS.

## Parameters
- $1: Target URL/IP or file path
- $2: Optional category (web/pwn/crypto/misc/reverse/auto)

## Execution Flow

### 1. Enable CTF Mode
```
enable_ctf_mode()
```

### 2. Parse Parameters
Extract TARGET and CATEGORY from $ARGUMENTS. If CATEGORY not specified, use "auto" for automatic detection.

### 3. Select Solving Strategy Based on Category

**Web Challenge** (category=web or HTTP service detected):
```
ctf_web_comprehensive_solver(
    target=TARGET,
    challenge_info={"category": "web", "description": "CTF Web Challenge"},
    time_limit="30min"
)
```

**PWN Challenge** (category=pwn or binary file detected):
```
quick_pwn_check(binary_path=TARGET)
ctf_pwn_solver(
    target=TARGET,
    challenge_info={"category": "pwn"},
    time_limit="30min"
)
```

**Crypto Challenge** (category=crypto):
```
ctf_crypto_solver(
    target=TARGET,
    challenge_info={"category": "crypto"},
    time_limit="30min"
)
```

**Misc Challenge** (category=misc):
```
ctf_misc_solver(
    target=TARGET,
    challenge_info={"category": "misc"},
    time_limit="30min"
)
```

**Reverse Challenge** (category=reverse):
```
auto_reverse_analyze(binary_path=TARGET)
ctf_reverse_solver(binary_path=TARGET)
```

**Auto Detection** (category=auto or not specified):
```
ctf_auto_detect_solver(
    target=TARGET,
    challenge_info={},
    time_limit="30min"
)
```

### 4. Extract Flags
```
get_detected_flags()
```

### 5. Generate Solution Report
- Summarize attack path
- List all discovered flags
- Provide reproducible PoC scripts

## Examples
- /ctf http://challenge.ctf.com:8080
- /ctf http://web.ctf.com web
- /ctf /tmp/pwn_binary pwn
- /ctf encrypted.txt crypto
