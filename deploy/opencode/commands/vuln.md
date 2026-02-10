---
description: Vulnerability assessment for specific vulnerability types
agent: security
model: anthropic/claude-3-5-sonnet-20241022
subtask: true
---

Execute vulnerability assessment for target $ARGUMENTS with specified vulnerability type.

## Parameters
- $1: Target URL/IP
- $2: Optional vulnerability type (sql/xss/rce/lfi/ssrf/xxe/all)

## Execution Flow

### 1. Parse Parameters
Extract TARGET and TYPE from $ARGUMENTS. Default TYPE = all.

### 2. Execute Testing Based on Vulnerability Type

**SQL Injection** (type=sql):
```
# Automated SQL injection detection
sqlmap_scan(url=TARGET, additional_args="--batch --crawl=2 --forms")

# Intelligent SQL injection payloads
intelligent_sql_injection_payloads(target_url=TARGET, waf_detected=detected_WAF_result)
```

**XSS Cross-Site Scripting** (type=xss):
```
# Intelligent XSS payload generation
intelligent_xss_payloads(target_url=TARGET, browser_type="chrome", content_type="html")

# Use Nuclei XSS templates
nuclei_scan(target=TARGET, tags="xss")
```

**Remote Code Execution** (type=rce):
```
# Command injection testing
intelligent_command_injection_payloads(target_url=TARGET, os_type="linux")

# RCE vulnerability scanning
nuclei_scan(target=TARGET, tags="rce")

# Search for known RCE vulnerabilities
searchsploit_search(term=technology_stack_identified_from_target)
```

**Local File Inclusion** (type=lfi):
```
# LFI-specific payloads
generate_intelligent_payload(vulnerability_type="lfi", quantity=10)

# LFI vulnerability scanning
nuclei_scan(target=TARGET, tags="lfi")
```

**SSRF Server-Side Request Forgery** (type=ssrf):
```
# SSRF-specific payloads
generate_intelligent_payload(vulnerability_type="ssrf", quantity=10)

# SSRF vulnerability scanning
nuclei_scan(target=TARGET, tags="ssrf")
```

**XXE XML External Entity** (type=xxe):
```
# XXE-specific payloads
generate_intelligent_payload(vulnerability_type="xxe", quantity=10)

# XXE vulnerability scanning
nuclei_scan(target=TARGET, tags="xxe")
```

**Comprehensive Scan** (type=all):
```
# Comprehensive vulnerability assessment
intelligent_vulnerability_assessment(target=TARGET, assessment_depth="comprehensive")

# Multi-type Nuclei scanning
nuclei_scan(target=TARGET, severity="critical,high,medium")
```

### 3. Generate Report
- Vulnerability type and location
- Risk level (CVSS score)
- Exploitation PoC
- Remediation recommendations

## Examples
- /vuln http://target.com/page?id=1 sql
- /vuln http://target.com/search xss
- /vuln http://target.com all
