# used to create folders and set NTFS permissions for specific groups

#shares is an array of hashtables containing share names and their corresponding groups
$shares = @(
    @{ Name = "HR"; Group = "hr-group" },
    @{ Name = "IT"; Group = "it-group" },
    @{ Name = "Accounting"; Group = "accounting-group" }
)

# loop through each share to create the folder and set permissions
foreach ($share in $shares) {
    $folderPath = "C:\Shares\$($share.Name)"

    # Create folder if it doesn't exist
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath -Force | Out-Null
    }

    # Remove inheritance using ICACLS
    icacls $folderPath /inheritance:r

    # Grant modify permissions to the specific group and full control to Domain Admins
    icacls $folderPath /grant:r "TESTENV\$($share.Group):(OI)(CI)M" "TESTENV\Domain Admins:(OI)(CI)F"

    Write-Host "Configured NTFS for: $folderPath"
}

# Pause and wait for user input before closing
Write-Host "`Folder creation complete!" 
Write-Host "Press any key to continue..." 
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")