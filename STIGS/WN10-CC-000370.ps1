<#
.SYNOPSIS
    This PowerShell script ensures the convenience PIN for Windows 10 is disabled.

.NOTES
    Author          : Nick Pamatian
    LinkedIn        : https://www.linkedin.com/in/nick-pamatian-b8828b28a/
    GitHub          : https://github.com/nickpamatian
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000370.ps1 
#>

# Define registry path and value
$registryPath = 'HKLM:\Software\Policies\Microsoft\Windows\System'
$valueName = 'AllowDomainPINLogon'
$desiredValue = 0

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    Write-Host "Registry path does not exist. Creating it..."
    New-Item -Path $registryPath -Force | Out-Null
}

# Check if the value exists and if it is set correctly
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue -ne $desiredValue) {
    Write-Host "Setting registry value: $valueName = $desiredValue"
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
} else {
    Write-Host "Registry value is already set correctly."
}
