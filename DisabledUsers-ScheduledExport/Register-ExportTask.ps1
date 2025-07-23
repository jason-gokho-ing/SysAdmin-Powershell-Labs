# Powershell script to run automated task of checking for disabled users. 
# Needed to create a scheduled task that executes the Export-DisabledUsers.ps1 script daily at 9 AM.


# Load module for scheduled tasks
Import-Module ScheduledTasks -ErrorAction Stop

# Create folders if needed
New-Item "C:\Scripts" -ItemType Directory -Force
New-Item "C:\Reports" -ItemType Directory -Force

# Move your script to the Scripts folder if it's not there already
Move-Item ".\Export-DisabledUsers.ps1" -Destination "C:\Scripts\Export-DisabledUsers.ps1" -Force

# Create a daily task to run at 9 AM
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File C:\Scripts\Export-DisabledUsers.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At 9:00AM
# Set the principal to run as SYSTEM with highest privileges
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName "ExportDisabledUsers" -Action $action -Trigger $trigger -Principal $principal -Description "Daily export of disabled AD users"

