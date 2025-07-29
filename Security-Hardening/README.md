# 🛡️ Windows Security Hardening & Backup Strategy

This project demonstrates comprehensive Windows system administration skills: implementing enterprise security baselines through Group Policy, configuring automated backup strategies, and establishing ongoing security monitoring. Perfect for showcasing Tier 2 System Administrator capabilities in security compliance, disaster recovery planning, and operational monitoring in a domain environment.

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

📁 *GPO Report is available in `/GPO Reports/Security_Baseline.htm`*

---

### Why These Settings Matter

#### **Password Policies & Account Lockout**
- **12-character minimum**: Short passwords can be cracked in minutes using modern tools. A 12-character password takes exponentially longer to break through brute force attacks (automated password guessing).
- **Account lockout after 5 attempts**: This stops attackers from repeatedly trying different passwords. Without lockout, an attacker could try thousands of password combinations automatically.

#### **User Account Control (UAC) & Secure Login**
- **UAC prompts**: When enabled, Windows asks for permission before allowing administrative changes. This prevents malware from silently installing or modifying system settings.
- **Ctrl+Alt+Del requirement**: This creates a "secure attention sequence" that only Windows can intercept, making it impossible for keylogger malware to capture your login credentials.

#### **Guest Account & Network Access Controls**
- **Guest account disabled**: The guest account allows anyone to log in without a password. Disabling it removes an easy entry point for attackers who gain physical access to machines.

#### **Remote Access & Firewall Protection**
- **RDP disabled by default**: Remote Desktop Protocol is frequently targeted by ransomware groups. Disabling it unless specifically needed reduces liklihood of getting hacked
- **Windows Defender Firewall enabled**: Acts as the first line of defense, blocking unauthorized network connections and malicious traffic from reaching your system.


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


![Client Domain Join](images/domain-join-success.png)


📁 *See `/Backup_Config` for screenshots and logs.*

---

## ✅ 3. Backup Validation

Steps Performed:

- Confirmed backup job created in WSB  
- Verified completion via Event Viewer (Event ID 4)  
- Performed **manual file restore test**  
- Confirmed NTFS metadata and data integrity

📁 *Report available in `Restore_Test_Report.txt`*

---

## 4. Security Monitoring & Compliance

### 🔍 Event Log Analysis
- **Failed login attempts**: Monitored Security Event ID 4625 for brute force indicators
- **Policy changes**: Tracked Event ID 4719 for unauthorized GPO modifications
- **Account lockouts**: Reviewed Event ID 4740 to validate lockout policy effectiveness

### 📊 Compliance Verification
- **Password policy audit**: Verified all domain accounts meet 12-character requirement
- **Guest account status**: Confirmed guest account disabled across all domain machines
- **Firewall status**: Validated Windows Defender Firewall enabled on all workstations

📁 *Security audit results in `/Security_Audit_Report.xlsx`*

---

## 🧠 Skills Demonstrated

- **Group Policy Management**: Applied security baselines using GPMC
- **Windows Server Backup**: Configured automated daily backup schedules  
- **System Validation**: Performed backup testing and recovery verification
- **Security Monitoring**: Analyzed Windows Event Logs for security indicators
- **Compliance Auditing**: Verified policy enforcement across domain environment
- **Risk Assessment**: Documented security controls and business justifications

---

## 🧰 Tools Used

- Windows Server 2025 (DC + File Server)  
- Windows Server Backup (GUI)  
- Group Policy Management Console (GPMC)  
- Event Viewer  
- NTFS Permissions (optional)  
- Hyper-V Virtual Lab

