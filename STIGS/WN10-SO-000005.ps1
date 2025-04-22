<#
.SYNOPSIS
    This PowerShell script ensures the built-in administrator account is disabled.

.NOTES
    Author          : Nick Pamatian
    LinkedIn        : https://www.linkedin.com/in/nick-pamatian-b8828b28a/
    GitHub          : https://github.com/nickpamatian
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000005.ps1 
#>

# Get the built-in Administrator account using its well-known RID (500)
$adminAccount = Get-WmiObject -Class Win32_UserAccount | Where-Object { $_.SID -like "*-500" }

if ($adminAccount) {
    try {
        # Disable the Administrator account using WMIC
        wmic useraccount where "sid='$($adminAccount.SID)'" set disabled=true
        Write-Output "Administrator account (SID: $($adminAccount.SID)) has been successfully disabled."
    } catch {
        Write-Error "Failed to disable Administrator account: $_"
    }
} else {
    Write-Warning "Built-in Administrator account not found."
}
