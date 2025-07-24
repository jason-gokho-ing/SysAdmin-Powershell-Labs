# 🖥️ IT Automation & System Administration Portfolio

This portfolio showcases hands-on IT projects built using PowerShell and Windows Server technologies.  
Each project demonstrates practical skills in Active Directory, Windows Server, Group Policy, file permissions, automation, and IT maintenance — aligned with Tier 1–2 IT Support and Sysadmin roles.

Scripts and tools were tested in a custom-built Hyper-V lab using domain-joined Windows environments.

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

### 📤 [Disabled Users: Scheduled Export](./DisabledUsers-ScheduledExport)
Creates a scheduled task to run a PowerShell script daily, exporting a list of disabled Active Directory accounts. Useful for compliance, audits, and regular cleanups.

- Tools: PowerShell, Task Scheduler
- Skills: Maintenance automation, reporting, Active Directory querying

---

## 🧰 About This Lab

These projects were built and tested in a Hyper-V lab environment using:
- Windows Server 2025 (Domain Controller & File Server)
- Windows 10/11 Clients (Domain-joined)
- PowerShell 5.1+
- Group Policy Management Console

---


