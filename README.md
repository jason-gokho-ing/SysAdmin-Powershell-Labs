# 🖥️ IT Automation & System Administration Portfolio

This portfolio showcases hands-on IT projects built using PowerShell and Windows Server technologies.  
Each project demonstrates practical skills in Active Directory, Windows Server, Group Policy, file permissions, automation, and IT maintenance — aligned with Tier 1–2 IT Support and Sysadmin roles.

---

## 🧰 About This Lab

These projects were built and tested in a Hyper-V lab environment using:
- Windows Server 2025 (Domain Controller & File Server)
- Windows 10/11 Clients (Domain-joined)
- PowerShell 5.1+
- Group Policy Management Console
- Chocolatey

---

## 📁 Projects


### 🗂 [File Server & Access Management](./FileServer-AccessManagement)
Builds a secure file server with NTFS and share permissions based on department groups. Includes a permissions audit script and drive mapping via GPO.

- Tools: File Server Roles, NTFS, PowerShell, GPO
- Skills: Access control, documentation, disaster recovery

---

### 👥 [Active Directory User Creation](./Account-Creation)
Automates bulk user creation in Active Directory using a CSV import and PowerShell script. Assigns users to OU-based security groups and sets initial attributes like department and phone number.

- Tools: Active Directory, PowerShell, CSV
- Skills: User provisioning, organizational units, scripting for HR workflows

---

### 🚪 [IT Offboarding Workflow](./Offboarding-Workflow)
Simulates a real-world IT offboarding process by identifying disabled users, removing their group memberships, relocating their accounts to a secure OU, and exporting audit logs. The workflow is automated to run daily at 9:00 AM using Task Scheduler.

- Tools: Active Directory, PowerShell, Task Scheduler
- Skills: AD cleanup, user lifecycle management, PowerShell scripting, scheduled automation

---

### 🔐 [Security Hardening & Audit Automation](./Security-Hardening)
Simulates endpoint security configuration and compliance checks using Group Policy and PowerShell to enforce and audit hardened settings on Windows 10/11 domain clients.

- Tools: Windows Server 2022, Group Policy Management Console, PowerShell 5.1+, Hyper-V Lab
- Skills: Security baselining, Group Policy hardening, compliance auditing, PowerShell scripting, audit reporting, defense-in-depth

---


### 🧠 Skills Demonstrated
- Active Directory administration
- Group Policy creation and targeting
- PowerShell scripting and automation
- NTFS and share permission control
- Task Scheduler and reporting
- Security policy enforcement
- Software deployment via GPO & CLI tools
- Lab building and environment isolation

---

