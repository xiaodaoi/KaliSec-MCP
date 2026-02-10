---
description: APT attack simulation following MITRE ATT&CK framework
agent: security
model: anthropic/claude-3-5-sonnet-20241022
subtask: true
---

Execute Advanced Persistent Threat (APT) attack simulation for target $ARGUMENTS.

## Parameters
- $1: Target IP/domain

## Execution Flow

### 1. Start APT Session
```
start_attack_session(target=TARGET, mode="apt", session_name="APT_Campaign")
```

### 2. Execute Complete APT Attack Chain

**Phase 1: Reconnaissance**
```
# Passive intelligence gathering
theharvester_osint(domain=TARGET)
sherlock_search(username=extracted_username_from_target)

# Active reconnaissance
comprehensive_recon(target=TARGET, domain_enum=True, port_scan=True, web_scan=True)
```

**Phase 2: Weaponization**
```
# Generate targeted payloads based on reconnaissance results
ai_smart_payload_generation(
    target_context=reconnaissance_results,
    attack_type=identified_vulnerability_type,
    ai_hypothesis="attack_hypothesis_based_on_target_characteristics"
)
```

**Phase 3: Delivery**
```
# Try multiple delivery methods
intelligent_parallel_attack(target_url=TARGET, max_concurrent=8)
```

**Phase 4: Exploitation**
```
# Intelligent vulnerability exploitation
apt_comprehensive_attack(target=TARGET)
```

**Phase 5: Installation**
```
# Try persistence if access obtained
# Use Metasploit modules or custom scripts
```

**Phase 6: Command & Control**
```
# Establish reverse connection (authorized testing only)
```

**Phase 7: Actions on Objectives**
```
# Data collection and simulated exfiltration
```

### 3. Adaptive Strategy
```
# Start adaptive attack
start_adaptive_apt_attack(
    target=TARGET,
    attack_objective="full_compromise"
)
```

### 4. Generate APT Report
```
generate_poc_from_current_session()
end_attack_session()
```

## Report Content
- APT attack timeline
- Detailed execution for each MITRE ATT&CK phase
- Successful attack vectors
- Defensive recommendations (ATT&CK mitigations)
- Complete PoC and attack scripts

## Examples
- /apt 192.168.1.100
- /apt target-corp.com
