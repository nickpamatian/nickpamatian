<#
.SYNOPSIS
    This PowerShell script ensures the built-in guest account is renamed.

.NOTES
    Author          : Nick Pamatian
    LinkedIn        : https://www.linkedin.com/in/nick-pamatian-b8828b28a/
    GitHub          : https://github.com/nickpamatian
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000025.ps1 
#>

# Get the current name of the guest account (RID 501 is always the guest account)
$guestAccount = Get-WmiObject -Class Win32_UserAccount | Where-Object { $_.SID -like "*-501" }

# Check if the guest account exists and if the name is "Guest"
if ($guestAccount -and $guestAccount.Name -eq "Guest") {
    # Define the new name (change "DisabledGuest" to whatever name you'd prefer)
    $newName = "DisabledGuest"

    try {
        # Rename the account using WMIC
        wmic useraccount where "name='Guest'" rename $newName
        Write-Output "Guest account successfully renamed to '$newName'."
    } catch {
        Write-Error "Failed to rename Guest account: $_"
    }
} elseif ($guestAccount) {
    Write-Output "Guest account is already renamed to '$($guestAccount.Name)'. No action taken."
} else {
    Write-Warning "Guest account not found on this system."
}
