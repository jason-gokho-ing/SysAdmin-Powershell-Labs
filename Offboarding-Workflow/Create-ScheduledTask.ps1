# Powershell script to run automated task of checking for disabled users. 
# Needed to create a scheduled task that executes the Offboard-Users.ps1 script daily at 9 AM.


# Load ScheduledTasks module
Import-Module ScheduledTasks -ErrorAction Stop

# Prepare folders
New-Item "C:\Scripts" -ItemType Directory -Force
New-Item "C:\Reports" -ItemType Directory -Force

# Move script into place
Move-Item ".\Offboard-Users.ps1" -Destination "C:\Scripts\Offboard-Users.ps1" -Force

# Define task components
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File C:\Scripts\Offboard-Users.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At 9:00AM
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# Register the task
Register-ScheduledTask -TaskName "OffboardUsers" -Action $action -Trigger $trigger -Principal $principal -Description "Daily offboarding script for disabled users"