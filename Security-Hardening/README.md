# 🛡️ Windows Security Hardening & Backup Strategy

This project demonstrates essential Windows system administration skills: securing domain-joined systems with Group Policy and implementing reliable backups using Windows Server Backup. Perfect for demonstrating Tier 2 System Administrator capabilities in security baseline enforcement and data recovery planning.

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

📁 *GPO Report is available in `/GPO Reports`*

---

### Security Rationale: Why These Settings Matter

#### **Password Policies & Account Lockout**
- **12-character minimum**: Short passwords can be cracked in minutes using modern tools. A 12-character password takes exponentially longer to break through brute force attacks (automated password guessing).
- **Account lockout after 5 attempts**: This stops attackers from repeatedly trying different passwords. Without lockout, an attacker could try thousands of password combinations automatically.
- **Real-world impact**: Prevents credential stuffing attacks where hackers use stolen password lists from data breaches.

#### **User Account Control (UAC) & Secure Login**
- **UAC prompts**: When enabled, Windows asks for permission before allowing administrative changes. This prevents malware from silently installing or modifying system settings.
- **Ctrl+Alt+Del requirement**: This creates a "secure attention sequence" that only Windows can intercept, making it impossible for keylogger malware to capture your login credentials.
- **Real-world impact**: Stops many types of malware infections and prevents unauthorized system modifications.

#### **Guest Account & Network Access Controls**
- **Guest account disabled**: The guest account allows anyone to log in without a password. Disabling it removes an easy entry point for attackers who gain physical access to machines.
- **Real-world impact**: Eliminates a common vector used by attackers for initial access and lateral movement within networks.

#### **Remote Access & Firewall Protection**
- **RDP disabled by default**: Remote Desktop Protocol is frequently targeted by ransomware groups. Disabling it unless specifically needed reduces your attack surface.
- **Windows Defender Firewall enabled**: Acts as the first line of defense, blocking unauthorized network connections and malicious traffic from reaching your system.
- **Real-world impact**: Many recent ransomware attacks specifically target exposed RDP services to gain initial access to networks.

---

## 2. Windows Server Backup Configuration

The file server was configured for daily backups of:

- **System State** (for Active Directory recovery)  
- **Shared Data** (`C:\Shared` folder)

### 🛠️ Backup Settings

| Setting        | Value                         |
|----------------|-------------------------------|
| Tool Used      | Windows Server Backup (GUI)   |
| Schedule       | Daily at 8:00 PM              |
| Target Drive   | `D:\Backup` (mounted VHD)     |
| Backup Type    | Full volume + system state    |
| Retention      | 30 days (automatic cleanup)   |
| Monitoring     | Manual via Event Viewer       |

### Why These Backup Choices Matter

- **System State backup**: Contains Active Directory database, registry, and boot files. Critical for domain controller recovery after hardware failure or corruption.
- **8:00 PM schedule**: Runs during off-hours to minimize impact on users and system performance.
- **Separate VHD target**: Isolates backup data from main system drive. If primary storage fails, backups remain accessible.
- **30-day retention**: Balances storage space with recovery options. Allows recovery from issues discovered weeks later.

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

## 🧠 Skills Demonstrated

- **Group Policy Management**: Applied security baselines using GPMC
- **Windows Server Backup**: Configured automated daily backup schedules  
- **System Validation**: Performed backup testing and recovery verification
- **Security Documentation**: Created compliance matrices and risk assessments

---

## 🧰 Tools Used

- Windows Server 2025 (DC + File Server)  
- Windows Server Backup (GUI)  
- Group Policy Management Console (GPMC)  
- Event Viewer  
- NTFS Permissions (optional)  
- Hyper-V Virtual Lab

