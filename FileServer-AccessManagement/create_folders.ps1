# File Server Management Script - Create folders and generate permissions report

# Define the departments that need shared folders
$departments = @("HR", "IT", "Accounting")
$shareFolder = "C:\Shares"
$reportFile = "C:\Scripts\FolderPermissions_Report.csv"


# Create Folders and Set Permissions
Write-Host "STEP 1: Creating department folders..." 

foreach ($dept in $departments) {
    $folderPath = "$shareFolder\$dept"
    
    Write-Host "Processing $dept folder..." 

    # Create the folder if it doesn't exist
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath -Force | Out-Null
        Write-Host "  [CREATED] Folder: $folderPath" 
    } else {
        Write-Host "  [EXISTS] Folder already exists: $folderPath" 
    }

    # Set permissions using simple ICACLS commands
    try {
        # Remove inherited permissions to start clean
        icacls $folderPath /inheritance:r | Out-Null
        
        # Give the department group modify access
        icacls $folderPath /grant "TESTENV\$dept-Group:(OI)(CI)M" | Out-Null
        
        # Give Domain Admins full control
        icacls $folderPath /grant "TESTENV\Domain Admins:(OI)(CI)F" | Out-Null
        
        Write-Host "  [SUCCESS] Permissions set for $dept-Group" 
    }
    catch {
        Write-Warning "  [ERROR] Failed to set permissions for $folderPath"
    }
}

Write-Host "STEP 1 Complete: All folders created!" 

# Generate Permissions Report
Write-Host "STEP 2: Generating permissions report..." 

# Create Scripts folder if needed
New-Item -ItemType Directory -Path "C:\Scripts" -Force | Out-Null

Write-Host "Scanning folders in $shareFolder..." 

# Collect permission data
$permissionData = @()

# Get each department folder
Get-ChildItem -Path $shareFolder -Directory | ForEach-Object {
    $currentFolder = $_.FullName
    $folderName = $_.Name
    
    Write-Host "  Checking permissions for: $folderName" 
    
    # Get the security settings for this folder
    $folderSecurity = Get-Acl -Path $currentFolder
    
    # Look at each permission entry
    foreach ($permission in $folderSecurity.Access) {
        # Create a simple data row
        $permissionData += [PSCustomObject]@{
            Folder = $folderName
            User_or_Group = $permission.IdentityReference.ToString()
            Access_Level = $permission.FileSystemRights.ToString()
            Permission_Type = $permission.AccessControlType.ToString()
        }
    }
}

# Save the report to CSV
$permissionData | Sort-Object Folder, User_or_Group | 
Export-Csv -Path $reportFile -NoTypeInformation

Write-Host "[DONE] Generated permissions report" 
Write-Host "[SAVED] Report saved to: $reportFile" 
Write-Host "Press any key to continue..." 
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")