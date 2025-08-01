# 🖥️ IT Systems, Automation & Infrastructure Portfolio

This portfolio showcases practical, hands-on IT projects focused on Windows Server administration, automation, security hardening, and infrastructure services. Each project highlights core Tier 1–2 sysadmin skills including Active Directory, Group Policy, file access management, user lifecycle automation, networking, and backup strategy — built and tested in a Hyper-V lab environment.

---

## 🧰 About This Lab

These projects were built and tested in a Hyper-V lab environment using:
- Windows Server 2025 (Domain Controller & File Server)
- Windows 10/11 Clients (Domain-joined)
- PowerShell 5.1+
- Group Policy Management Console

---

## 📁 Projects

### 👥 [Active Directory User Creation](./Account-Creation)
Automates bulk user creation in Active Directory using a CSV import and PowerShell script. Assigns users to OU-based security groups and sets initial attributes like department and phone number.

- Tools: Active Directory, PowerShell, CSV
- Skills: User provisioning, organizational units, scripting for HR workflows

---

### 🗂 [File Server & Access Management](./FileServer-AccessManagement)
Builds a secure file server with NTFS and share permissions based on department groups. Includes a permissions audit script and drive mapping via GPO.

- Tools: File Server Roles, NTFS, PowerShell, GPO
- Skills: Access control, documentation, NTFS/Share Permissions

---

### 🌐 [Network Services](./Network-Services)
Sets up core Windows Server infrastructure with DHCP and DNS to support Active Directory in a virtual domain. Automatically assigns IPs to clients and enables internal name resolution across domain-joined machines.

- Tools: Windows Server, Active Directory, DHCP, DNS, VMware (VMnet8 NAT)
- Skills: Domain controller setup, DHCP scope configuration, DNS zone management, domain joining, client-server communication, network troubleshooting

---

### 🚪 [IT Offboarding Workflow](./Offboarding-Workflow)
Simulates a real-world IT offboarding process by identifying disabled users, removing their group memberships, relocating their accounts to a secure OU, and exporting audit logs. The workflow is automated to run daily at 9:00 AM using Task Scheduler.

- Tools: Active Directory, PowerShell, Task Scheduler
- Skills: AD cleanup, user lifecycle management, PowerShell scripting, scheduled automation

---

### 🛡️ [Security Hardening & Backup Strategy](./Security-Hardening)
Implements comprehensive enterprise security controls through Group Policy and establishes robust backup/recovery procedures. Features security monitoring, compliance verification, and disaster recovery testing in a domain environment.

- Tools: Windows Server 2025, Group Policy Management Console, Windows Server Backup, Event Viewer, Security Event Logs
- Skills: Security baseline enforcement, GPO management, backup strategy, disaster recovery planning, security monitoring, compliance auditing, event log analysis

---
