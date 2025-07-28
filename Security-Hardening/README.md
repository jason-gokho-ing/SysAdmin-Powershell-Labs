# 🔐🛡️ Windows Security Hardening & Backup Strategy

This project demonstrates how to secure Windows domain-joined systems through Group Policy and implement a reliable backup and recovery plan using Windows Server Backup. It simulates core responsibilities of a Tier 2 System Administrator: protecting infrastructure from unauthorized access and ensuring critical data can be recovered in the event of failure or compromise.

---

## 🧪 Lab Environment

| Component           | Value                          |
|---------------------|--------------------------------|
| Domain Name         | `test-env.local`               |
| Domain Controller   | `dc-controller.test-env.local` |
| File Server         | `fs01.test-env.local`          |
| Clients             | Windows 10/11 domain-joined    |
| Backup Target       | Secondary virtual disk (VHD)   |

---

## 📋 1. Security Hardening (GPO)

A dedicated Group Policy Object (`Win10_Security_Baseline`) was applied to client machines in the **Workstations OU** to enforce baseline security standards.

### 🔐 Key Settings Implemented

#### Account Policies
- Password minimum length: **12 characters**
- Account lockout after 5 failed attempts

#### Local Security Options
- Disable LM hash storage
- Require Ctrl+Alt+Del at logon
- Enable User Account Control (UAC)

#### Network Restrictions
- Disable anonymous SID enumeration
- Disable guest account

#### Remote Access
- Disable RDP by default
- Enable Windows Defender Firewall

📁 *Screenshots of GPO settings are located in `/GPO_Screenshots`.*

---

## 🔄 2. Windows Server Backup Configuration

The **File Server** (`fs01`) was configured to perform daily backups of:

- System State (for AD recovery)
- Departmental shared folders (`D:\Shared`)

### 🛠️ Backup Configuration Details

- **Tool Used**: Windows Server Backup (WSB GUI)
- **Schedule**: Daily at 8:00 PM
- **Target Drive**: Separate VHD mounted as `E:\Backup`
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

| Category         | Setting/Action                      | Justification                            | Status |
|------------------|-------------------------------------|------------------------------------------|--------|
| GPO              | Enforce 12-char password length      | CIS baseline compliance                  | ✅     |
| GPO              | Disable LM hashes                    | Prevent legacy hash attacks              | ✅     |
| Backup           | System State + Data volume daily     | Disaster recovery readiness              | ✅     |
| Backup Validation| Manual file restore test             | Ensures recoverability                   | ✅     |
| Monitoring       | Event Viewer log review              | Confirms backup job success              | ✅     |

📁 *See `/Compliance_Matrix.xlsx` for full table.*

---

## 🧠 What This Project Demonstrates

- Tier 2-level understanding of **system hardening** using GPO
- Ability to plan and configure **reliable backup schedules**
- Experience using built-in Windows tools for backup and audit
- Awareness of **business continuity planning** in a Windows Server environment

---

## 🧰 Tools Used

- Windows Server 2022
- Windows Server Backup (GUI)
- Group Policy Management Console (GPMC)
- Event Viewer
- NTFS Permissions (optional)
- Hyper-V Virtual Lab

---

## 📁 Folder Structure

