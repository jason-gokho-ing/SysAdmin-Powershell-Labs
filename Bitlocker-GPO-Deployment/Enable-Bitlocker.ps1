# Set the drive you want to encrypt
$Drive = "C:"
$Log = "C:\BitLocker-Log.txt"

# Function to log actions to a file
function Write-Log($msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $msg" | Out-File -FilePath $Log -Append
}

# Log start of script
Write-Log "BitLocker script started."

# Check if drive is already encrypted or encrypting
try {
    $Status = (Get-BitLockerVolume -MountPoint $Drive).VolumeStatus
    Write-Log "Drive status: $Status"
} catch {
    Write-Log "ERROR: Failed to get BitLocker status. $_"
    return
}

if ($Status -eq "FullyEncrypted" -or $Status -eq "EncryptionInProgress") {
    Write-Log "Drive already encrypted or in progress. Exiting script."
    return
}

# Enable BitLocker with TPM and Recovery Password
try {
    Enable-BitLocker -MountPoint $Drive `
        -EncryptionMethod XtsAes256 `
        -UsedSpaceOnly `
        -TpmProtector `
        -RecoveryPasswordProtector

    Write-Log "BitLocker encryption command issued successfully."
} catch {
    Write-Log "ERROR: Failed to enable BitLocker. $_"
    return
}

# Backup recovery key to AD
try {
    $Key = (Get-BitLockerVolume -MountPoint $Drive).KeyProtector |
           Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"}

    Backup-BitLockerKeyProtector -MountPoint $Drive -KeyProtectorId $Key.KeyProtectorId
    Write-Log "Recovery key backed up to AD: $($Key.KeyProtectorId)"
} catch {
    Write-Log "ERROR: Failed to back up recovery key to AD. $_"
}

# Log script completion
Write-Log "BitLocker script completed."