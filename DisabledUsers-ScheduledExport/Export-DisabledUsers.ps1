
# This script gets a list of all disabled Active Directory users and saves it as a CSV file in C:\Reports.

# Set date for file naming
$date = Get-Date -Format "yyyy-MM-dd"

# Create folder if it doesn't exist
$folder = "C:\Reports"
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory
}

# Load Active Directory module
Import-Module ActiveDirectory

# Get disabled users
$disabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties Name, SamAccountName, Department, LastLogonDate

# Export to CSV if users found
if ($disabledUsers) {
    $disabledUsers | Select-Object Name, SamAccountName, Department, LastLogonDate |
        Export-Csv -Path "$folder\DisabledUsers_$date.csv" -NoTypeInformation
    Write-Output "Disabled users exported to $folder\DisabledUsers_$date.csv"
} else {
    Write-Output "No disabled users found."
}







