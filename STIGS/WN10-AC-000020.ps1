<#
.SYNOPSIS
    This PowerShell script ensures that the password history is configured to 24 passwords remembered.

.NOTES
    Author          : Nick Pamatian
    LinkedIn        : https://www.linkedin.com/in/nick-pamatian-b8828b28a/
    GitHub          : https://github.com/nickpamatian
    Date Created    : 2025-04-20
    Last Modified   : 2025-04-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000020.ps1 
#>

# PowerShell Script to Ensure 'Enforce Password History' is Set to at Least 24

# Check current setting
$currentValue = (secedit /export /cfg C:\Windows\Temp\secpol.cfg) | Out-Null
$configPath = "C:\Windows\Temp\secpol.cfg"
$passwordHistoryLine = Select-String -Path $configPath -Pattern "PasswordHistorySize"

if ($passwordHistoryLine) {
    $currentHistory = [int]($passwordHistoryLine -replace "PasswordHistorySize\s*=\s*", "").Trim()

    if ($currentHistory -lt 24) {
        Write-Host "Current value is $currentHistory. Updating to 24..."
        
        # Update the config file
        (Get-Content $configPath) -replace "PasswordHistorySize\s*=\s*\d+", "PasswordHistorySize = 24" |
            Set-Content $configPath

        # Apply the updated settings
        secedit /configure /db secedit.sdb /cfg $configPath /areas SECURITYPOLICY | Out-Null
        Write-Host "'Enforce password history' updated to 24 successfully."
    } else {
        Write-Host "'Enforce password history' is already set to $currentHistory or higher. No changes made."
    }
} else {
    Write-Warning "'PasswordHistorySize' setting not found in the security policy export."
}

# Clean up
Remove-Item $configPath -ErrorAction SilentlyContinue
