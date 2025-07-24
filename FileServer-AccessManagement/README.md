# 📁 File Server & Access Management (Windows Server Lab)

This project demonstrates how to build and manage a secure file server in a Windows Server domain environment. It includes automation scripts for folder creation and access control, Group Policy drive mapping, and auditing access permissions.

> ✅ Designed to simulate real-world Tier 2 Sysadmin responsibilities.

---

## 🔧 Lab Summary

- **Domain Name:** `test-env.local`
- **File Server:** `d-file-server.test-env.local`
- **Domain Controller:** `dc-controller.test-env.local`
- **Users & Groups:** Pre-created groups: `hr-group`, `it-group`, `accounting-group`
- **Clients:** Windows 10/11 domain-joined workstations

---

## 🗂️ Scripts Included

### `create_folders.ps1`

- Creates department folders (HR, IT, Accounting)
- Applies **NTFS permissions**:
  - `Domain Admins`: Full Control
  - Specific department group (e.g., `hr-group`): Modify
- Configures **Share permissions**:
  - Shared with **Everyone – Full Control**

> ⚠️ **Important:**\
> The folder is shared with `Everyone: Full Control` to simplify access.\
> Access is **still restricted securely** via NTFS permissions.\
> This setup is common in internal environments but should be reviewed in production scenarios.

> 🔐 Follows least privilege access principles using NTFS\
> 🛠️ Run as Administrator on the file server

---

### `folder_report.ps1`

- Audits folder access rights under `C:\Shares`
- Outputs NTFS permission data to a CSV report
- Captures `IdentityReference`, `AccessControlType`, and `Rights`

> 📊 Helps verify correct permissions are applied\
> 💼 Useful for security audits or onboarding documentation

---

## 🚗 Drive Mapping via GPO

- Created a GPO (`Map_Department_Shares`) with Drive Map preferences
- Item-Level Targeting used to map specific shares (e.g., `H:`, `I:`, `A:`) based on group membership
- Automates network drive availability upon user login

---

## ✅ What This Project Demonstrates

- Practical use of **NTFS + Share permissions** to restrict access
- Automating system admin tasks using **PowerShell**
- Group-based **drive mapping via Group Policy**
- Generating **audit reports** of file server permissions

---

## 🛠️ Tools Used

- Windows Server 2019/2022
- Active Directory + GPMC
- PowerShell 5.1+
- Hyper-V (local test lab)

---

## 🧠 Skills Practiced

- File Server configuration and access control
- Scripting in PowerShell for automation and auditing
- Group Policy management for user experience automation
- Security and access auditing fundamentals

---


