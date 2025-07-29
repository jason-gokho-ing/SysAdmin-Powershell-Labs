# 🛡️ Windows Security Hardening & Backup Strategy

This project demonstrates how to secure Windows domain-joined systems using Group Policy and implement a reliable backup strategy with Windows Server Backup. It reflects key Tier 2 Sysadmin responsibilities: enforcing security baselines and ensuring data recoverability.

---

## Lab Environment

| Component        | Value                         |
|------------------|-------------------------------|
| Domain Name      | test-env.local                |
| Domain Controller| dc-controller.test-env.local  |
| File Server      | file-server.test-env.local    |
| Clients          | Windows 10/11 (domain-joined) |
| Backup Target    | Secondary virtual disk (VHD)  |

---

### 1. Security Hardening (GPO)

A Group Policy Object (`Security-Baseline`) was applied to the **Workstations OU** to enforce standard security controls.

###  Key GPO Settings

| Category              | Settings                                                                 |
|-----------------------|--------------------------------------------------------------------------|
| **Account Policies**  | - Password min. length: 12 chars<br>- Lockout after 5 failed attempts    |
| **Local Security**    | - Require Ctrl+Alt+Del at login<br>- Enable UAC                          |
| **Network Access**    | - Disable guest account                                                  |
| **Remote Access**     | - Disable RDP by default<br>- Enable Windows Defender Firewall           |

📁 *Screenshots available in `/GPO_Screenshots`*

---

### Security Rationale (Brief Summary)

- **Strong Passwords + Lockout** → Prevent brute force attacks  
- **UAC + Secure Login** → Reduce privilege escalation + keylogger risk  
- **Guest Account Disabled** → Eliminates unauthorized local access vector  
- **Firewall + RDP Disabled** → Blocks common ransomware entry points

---

## 2. Windows Server Backup Configuration

The file server was configured for daily backups of:

- 🛡️ **System State** (for Active Directory recovery)  
- 📁 **Shared Data** (`C:\Shared` folder)

### 🛠️ Backup Settings

| Setting        | Value                         |
|----------------|-------------------------------|
| Tool Used      | Windows Server Backup (GUI)   |
| Schedule       | Daily at 8:00 PM              |
| Target Drive   | `D:\Backup` (mounted VHD)     |
| Backup Type    | Full volume + system state    |
| Monitoring     | Manual via Event Viewer       |

📁 *See `/Backup_Config` for screenshots and logs.*

---

## ✅ 3. Backup Validation

✔️ Steps Performed:

- Confirmed backup job created in WSB  
- Verified completion via Event Viewer (Event ID 4)  
- Performed **manual file restore test**  
- Confirmed NTFS metadata and data integrity

📁 *Report available in `Restore_Test_Report.txt`*

---

## 📊 4. Security & Recovery Matrix

| Category   | Action                                  | Justification                          | Status |
|------------|-----------------------------------------|----------------------------------------|--------|
| GPO        | Enforce 12-char password                | CIS/NIST compliance                    | ✅     |
| GPO        | Enable UAC                              | Prevent privilege escalation           | ✅     |
| GPO        | Require Ctrl+Alt+Del                    | Secure login against keyloggers        | ✅     |
| GPO        | Disable guest account                   | Eliminate unauthorized local access    | ✅     |
| GPO        | Disable RDP                             | Block remote attack surface            | ✅     |
| GPO        | Enable Windows Defender Firewall        | Block malicious traffic                | ✅     |
| Backup     | Daily System State + Data Backup        | Disaster recovery readiness            | ✅     |
| Validation | File restore test                       | Verifies backup integrity              | ✅     |
| Monitoring | Event Viewer log review                 | Confirms backup job success            | ✅     |

📁 *Full matrix available in `/Compliance_Matrix.xlsx`*

---

## 🧠 What This Project Demonstrates

- GPO-based system hardening aligned with real-world baselines  
- Daily backup planning using native Windows Server tools  
- Manual recovery validation and backup job monitoring  
- Strong focus on **business continuity** and **security compliance**

---

## 🧰 Tools Used

- Windows Server 2025 (DC + File Server)  
- Windows Server Backup (GUI)  
- Group Policy Management Console (GPMC)  
- Event Viewer  
- NTFS Permissions (optional)  
- Hyper-V Virtual Lab

