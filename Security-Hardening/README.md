# 🔐🛡️ Windows Security Hardening & Backup Strategy

This project demonstrates how to secure Windows domain-joined systems through Group Policy and implement a reliable backup and recovery plan using Windows Server Backup. It simulates core responsibilities of a Tier 2 System Administrator: protecting infrastructure from unauthorized access and ensuring critical data can be recovered in the event of failure or compromise.

---

## 🧪 Lab Environment

| Component           | Value                          |
|---------------------|--------------------------------|
| Domain Name         | `test-env.local`               |
| Domain Controller   | `dc-controller.test-env.local` |
| File Server         | `file-server.test-env.local`   |
| Clients             | Windows 10/11 domain-joined    |
| Backup Target       | Secondary virtual disk (VHD)   |

---

## 📋 1. Security Hardening (GPO)

A dedicated Group Policy Object (`Security-Baseline`) was applied to client machines in the **Workstations OU** to enforce baseline security standards.

### 🔐 Key Settings Implemented

| Setting | Screenshot |
|---------|------------|
| **Account Policies**<br>• Password minimum length: **12 characters**<br>• Account lockout after 5 failed attempts | <img src="images/account_policies.png" alt="Account Policies" width="250"> |

| **Security Rationale** |
|-------------------------|
| *These password policies form the foundation of authentication security. The 12-character minimum prevents weak passwords vulnerable to dictionary and brute force attacks, while account lockout protects against automated credential stuffing attempts. This configuration aligns with NIST SP 800-63B guidelines and CIS security benchmarks, significantly reducing the risk of unauthorized access through compromised credentials.* |

| **Local Security Options**<br>• Require Ctrl+Alt+Del at logon<br>• Enable User Account Control (UAC) | <img src="images/local_security.png" alt="Local Security Options" width="250"> |

| **Security Rationale** |
|-------------------------|
| *These settings address critical security vulnerabilities: Ctrl+Alt+Del requirement creates a secure attention sequence that prevents keylogger malware from intercepting login credentials. UAC ensures administrative operations require explicit user consent, preventing privilege escalation attacks and unauthorized system modifications by requiring administrator approval for sensitive system changes.* |

| **Network Restrictions**<br>• Disable guest account | <img src="images/network_restrictions.png" alt="Network Restrictions" width="250"> |

| **Security Rationale** |
|-------------------------|
| *The guest account provides an unnecessary entry point for unauthorized access and is commonly exploited for initial foothold and lateral movement within the network. Disabling this account eliminates a potential attack vector and reduces the overall attack surface of the system.* |

| **Remote Access**<br>• Disable RDP by default<br>• Enable Windows Defender Firewall | <img src="images/remote_access.png" alt="Remote Access Settings" width="250"> |

| **Security Rationale** |
|-------------------------|
| *Remote access controls are critical for preventing external threats. RDP is disabled by default to eliminate a common attack vector used in ransomware and data breaches. Windows Defender Firewall provides network-level protection by blocking unauthorized inbound connections while allowing legitimate traffic, creating a defensive barrier against network-based attacks and malware communication.* |



---

## 🔄 2. Windows Server Backup Configuration

The **File Server** (`file-server`) was configured to perform daily backups of:

- System State (for AD recovery)
- Departmental shared folders (`C:\Shared`)

### 🛠️ Backup Configuration Details

- **Tool Used**: Windows Server Backup (WSB GUI)
- **Schedule**: Daily at 8:00 PM
- **Target Drive**: Separate VHD mounted as `D:\Backup`
- **Backup Type**: Full volume + system state
- **Notification**: Manual check via Event Viewer

📁 *See `/Backup_Config` for screenshots and logs.*

---

## ✅ 3. Backup Validation & Monitoring

### ✔️ Validation Steps Performed

- Verified backup job creation in WSB
- Monitored backup completion via **Event Viewer** (Event ID 4: "The backup operation has completed successfully.")
- Performed a **manual file restore** test from backup volume
- Verified restored folder matched original (NTFS metadata preserved)

📁 *Validation logs and test report included in `Restore_Test_Report.txt`*

---

## 📊 4. Security & Recovery Matrix

| Category         | Setting/Action                       | Justification                         | Status |
|------------------|--------------------------------------|---------------------------------------|--------|
| GPO              | Enforce 12-char password length     | CIS baseline compliance               | ✅     |
| GPO              | Enable User Account Control (UAC)   | Prevent privilege escalation attacks  | ✅     |
| GPO              | Require Ctrl+Alt+Del at logon      | Protect against keylogger attacks     | ✅     |
| GPO              | Disable guest account               | Eliminate unauthorized access vector   | ✅     |
| GPO              | Disable RDP by default              | Prevent remote access attacks         | ✅     |
| GPO              | Enable Windows Defender Firewall   | Block malicious network traffic       | ✅     |
| Backup           | System State + Data volume daily    | Disaster recovery readiness           | ✅     |
| Backup Validation| Manual file restore test            | Ensures recoverability                | ✅     |
| Monitoring       | Event Viewer log review             | Confirms backup job success           | ✅     |

📁 *See `/Compliance_Matrix.xlsx` for full table.*

---

## 🧠 What This Project Demonstrates

- Tier 2-level understanding of **system hardening** using GPO
- Ability to plan and configure **reliable backup schedules**
- Experience using built-in Windows tools for backup and audit
- Awareness of **business continuity planning** in a Windows Server environment

---

## 🧰 Tools Used

- Windows Server 2025
- Windows Server Backup (GUI)
- Group Policy Management Console (GPMC)
- Event Viewer
- NTFS Permissions (optional)
- Hyper-V Virtual Lab

---



