# 📦 Software Deployment via GPO & Chocolatey (Windows Server Lab)

This project demonstrates automated software deployment to domain-joined Windows clients using two methods: MSI deployment via Group Policy and CLI-based scripting with Chocolatey.

Simulates scalable deployment workflows used in helpdesk, desktop support, and junior sysadmin roles.

---

## 🧪 Lab Environment

| Component         | Name                         |
|------------------|------------------------------|
| Domain Name       | `test-env.local`             |
| Domain Controller | `dc-controller.test-env.local` |
| File Share        | `\\file-server\deploy`       |
| Clients           | Windows 10/11 workstations   |

---

## 1️⃣ MSI Deployment via Group Policy

- Created shared folder `\\file-server\deploy` for software packages
- Placed `.msi` installers (e.g., 7-Zip, Adobe Reader)
- Created GPO: `Software_Deploy_7zip_Adobe`
- Configured under:
  `Computer Configuration > Policies > Software Settings > Software Installation`

> Clients install packages at next reboot or refresh cycle

---

## 2️⃣ Chocolatey Deployment Script: `install_software.ps1`

- Installs Chocolatey silently using `Set-ExecutionPolicy` and web install
- Deploys software using CLI packages:
```powershell
choco install 7zip.install -y
choco install adobereader -y
