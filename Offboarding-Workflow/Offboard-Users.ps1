
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



#  This script offboards users by moving them to a specific OU, removing them from groups, and clearing certain attributes.
# It also logs the actions taken for each user in a CSV file.
Import-Module ActiveDirectory

$RootDN = "OU=Company XYZ, DC=test-env, DC=local"
$UsersOU = "OU=Users,$RootDN"

# create Disabled Users OU within the Users to better organize
New-ADOrganizationalUnit -Name "Disabled Users" -Path $UsersOU -ProtectedFromAccidentalDeletion $false

# Note: Make sure that the DisabledUsers OU exists in your Active Directory before running this script.
# create variables for the DisabledUsers OU and log file
$disabledOU = "OU=Disabled Users,$UsersOU" 
$folder = "C:\Reports"
# Set date for file naming
$date = Get-Date -Format "yyyy-MM-dd"
# Set log file path
$logFile = "$folder\OffboardingLog_$date.csv"

# Create Report folder if it doesn't exist
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory | Out-Null
}


# Get all disabled users from AD with properties needed
$disabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties MemberOf, DistinguishedName, Department, Manager

# Prepare an array to collect log entries
$logResults = @()

# Loop through each disabled user and perform offboarding actions
foreach ($user in $disabledUsers) {

    # Write status to console for monitoring
    Write-Output "Offboarding user: $($user.SamAccountName) - $($user.Name)"

    # Move user to DisabledUsers OU
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $disabledOU

    # Remove user from all groups except Domain Users
    foreach ($groupDN in $user.MemberOf) {
        $group = Get-ADGroup -Identity $groupDN
        if ($group.Name -ne "Domain Users") {
            Remove-ADGroupMember -Identity $group.Name -Members $user.SamAccountName -Confirm:$false
        }
    }

    # Clear Department and Manager attributes to remove personal information
    Set-ADUser -Identity $user.SamAccountName -Clear Department, Manager

    # Add a log entry for this user. PSCustomObject is used to create structured log entries
    $logResults += [PSCustomObject]@{
        SamAccountName = $user.SamAccountName
        Name = $user.Name
        Status = "Offboarded"
        Date = $date
    }
}

# Export the log entries to CSV for audit trail
$logResults | Export-Csv -Path $logFile -NoTypeInformation

Write-Output "Offboarding completed. Log saved to $logFile"



