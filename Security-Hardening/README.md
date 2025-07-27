# 🔐 Security Hardening & Audit Automation (Windows Server Lab)

This project demonstrates how to harden Windows 10/11 clients in a domain environment using Group Policy and validate applied settings using a PowerShell audit script. It simulates real-world security practices aligned with Tier 2 Sysadmin responsibilities.

---

## 🧪 Lab Environment

| Component         | Name                         |
|------------------|------------------------------|
| Domain Name       | `test-env.local`             |
| Domain Controller | `dc-controller.test-env.local` |
| Clients           | Windows 10/11 workstations   |
| GPO Name          | `Win10_Security_Baseline`    |

---

## 1️⃣ Security GPO Configuration

Created a GPO with hardened security settings:

- **Account Policies**
  - Password minimum length: 12 characters
  - Account lockout: 5 failed attempts
- **Local Security Options**
  - Disabled LM hashes
  - Enabled UAC
  - Required Ctrl+Alt+Del
- **Network Restrictions**
  - Disabled anonymous SID enumeration
  - Disabled guest account
- **Remote Access**
  - Disabled RDP by default
  - Configured Windows Defender Firewall rules

> ✅ GPO linked to the `Workstations` OU and verified using Group Policy Modeling.

---

## 2️⃣ PowerShell Audit Script: `audit_security_settings.ps1`

This script performs compliance checks for hardened settings:

- Queries system security policies via `secedit`, `Get-ItemProperty`, and `Get-GPResultantSetOfPolicy`
- Compares each setting to expected baseline values
- Outputs a CSV report showing compliant vs non-compliant endpoints

### 📁 Output Example:

| Hostname | Policy                | Expected | Actual | Compliant |
|----------|-----------------------|----------|--------|-----------|
| PC01     | Password Length       | 12       | 8      | ❌         |
| PC02     | RDP Enabled           | False    | False  | ✅         |

---

## ✅ What This Project Demonstrates

- Group Policy configuration for secure environments
- PowerShell automation for system auditing
- Real-world security baseline validation
- Compliance reporting for internal IT audits

---

## 🧰 Tools Used

- Windows Server 2022
- Group Policy Management Console (GPMC)
- PowerShell 5.1+
- `secedit`, `Get-GPResultantSetOfPolicy`
- Hyper-V virtual lab
