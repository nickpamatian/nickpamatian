<#
.SYNOPSIS
    This PowerShell script ensures that the machine inactivity limit is set to 15 minutes, locking the system with the screensaver.

.NOTES
    Author          : Nick Pamatian
    LinkedIn        : https://www.linkedin.com/in/nick-pamatian-b8828b28a/
    GitHub          : https://github.com/nickpamatian
    Date Created    : 2025-04-14
    Last Modified   : 2025-04-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000070.ps1 
#>

# Define registry path and parameters
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "InactivityTimeoutSecs"
$valueData = 900  # Decimal value (0x384 in hex)

# Ensure the registry key exists
New-Item -Path $regPath -Force | Out-Null

# Set the DWORD value
Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord
