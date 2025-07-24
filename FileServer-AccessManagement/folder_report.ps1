# Run this script on the File Server to collect permissions for all shares and save them to a CSV file.
New-Item -ItemType Directory -Path "C:\Scripts" -Force

# basePath is used to specify the root directory where the shares are located.
# reportPath is used to specify where the permissions report will be saved.
$basePath = "C:\Shares"
$reportPath = "C:\Scripts\SharePermissions_Report.csv"

# report will contain the permissions for each folder in the basePath.
$report = @()

Get-ChildItem -Path $basePath -Directory | ForEach-Object {
    $folderPath = $_.FullName
    $acl = Get-Acl -Path $folderPath


    # Collecting permissions for each folder
    foreach ($entry in $acl.Access) {
        $report += [PSCustomObject]@{
            FolderPath        = $folderPath
            IdentityReference = $entry.IdentityReference.ToString()
            Rights            = $entry.FileSystemRights.ToString()
            AccessControlType = $entry.AccessControlType.ToString()
            Inherited         = $entry.IsInherited
        }
    }
}

# Exporting the collected permissions to a CSV file
$report | Sort-Object FolderPath, IdentityReference -Unique |
Export-Csv -Path $reportPath -NoTypeInformation

Write-Output "Permissions report saved to $reportPath"
Write-Host "Press any key to continue..." 
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")