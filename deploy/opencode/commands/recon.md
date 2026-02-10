---
description: Information gathering and reconnaissance for security testing
agent: security
model: anthropic/claude-3-5-sonnet-20241022
subtask: true
---

Execute comprehensive information gathering and reconnaissance for target $ARGUMENTS.

## Parameters
- $1: Target domain/IP/URL
- $2: Optional depth (quick/standard/deep)

## Execution Flow

### 1. Parse Parameters
Extract TARGET and DEPTH from $ARGUMENTS. Default DEPTH = standard.

### 2. Determine Target Type
- Domain → Execute domain reconnaissance flow
- IP address → Execute network reconnaissance flow
- URL → Execute web application reconnaissance flow

### 3. Domain Target Reconnaissance

**Quick Mode** (depth=quick):
```
subfinder_scan(domain=TARGET)
whatweb_scan(target=TARGET)
```

**Standard Mode** (depth=standard):
```
# Subdomain enumeration
subfinder_scan(domain=TARGET)
amass_enum(domain=TARGET, mode="enum")

# DNS information
dnsrecon_scan(domain=TARGET)

# Technology identification
whatweb_scan(target=TARGET, aggression="3")
nuclei_technology_detection(target=TARGET)

# OSINT
theharvester_osint(domain=TARGET, sources="google,bing,linkedin")
```

**Deep Mode** (depth=deep):
```
# Complete reconnaissance
comprehensive_recon(target=TARGET, domain_enum=True, port_scan=True, web_scan=True)

# More subdomain sources
sublist3r_scan(domain=TARGET)
dnsenum_scan(domain=TARGET)

# Deep OSINT
auto_osint_workflow(target_domain=TARGET, scope="extensive")
```

### 4. IP Target Reconnaissance

**Quick Mode**:
```
nmap_scan(target=TARGET, scan_type="-sV -T4", ports="1-1000")
```

**Standard Mode**:
```
nmap_scan(target=TARGET, scan_type="-sV -sC", ports="1-10000")
nuclei_network_scan(target=TARGET)
```

**Deep Mode**:
```
comprehensive_network_scan(target=TARGET, deep_scan=True)
auto_network_discovery_workflow(target_network=TARGET)
```

### 5. Web Application Reconnaissance

```
# Technology stack identification
whatweb_scan(target=TARGET)
wafw00f_scan(target=TARGET)

# Directory scanning
gobuster_scan(url=TARGET, mode="dir")

# Vulnerability pre-scan
nuclei_scan(target=TARGET, severity="critical,high")
```

### 6. Output Information Summary
- List of discovered subdomains
- Open ports and services
- Technology stack information
- Potential attack surface
- Recommended next actions

## Examples
- /recon example.com
- /recon 192.168.1.0/24 quick
- /recon https://target.com deep
