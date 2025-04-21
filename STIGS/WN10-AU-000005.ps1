<#
.SYNOPSIS
    This PowerShell script ensures the system is configured to audit Account Logon - Credential Validation failures.

.NOTES
    Author          : Nick Pamatian
    LinkedIn        : https://www.linkedin.com/in/nick-pamatian-b8828b28a/
    GitHub          : https://github.com/nickpamatian
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000005.ps1 
#>

# Function to enable "Audit: Force audit policy subcategory settings..." (WN10-SO-000030)
function Enable-ForceAuditPolicyOverride {
    $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
    $name = "SCENoApplyLegacyAuditPolicy"
    $desiredValue = 1

    try {
        # Create key if not present
        if (-not (Test-Path $registryPath)) {
            New-Item -Path $registryPath -Force | Out-Null
        }

        # Set the registry value
        Set-ItemProperty -Path $registryPath -Name $name -Value $desiredValue -Type DWord
        Write-Output "Successfully enabled: Force audit policy subcategory override (SCENoApplyLegacyAuditPolicy = 1)."
    } catch {
        Write-Error "Failed to set SCENoApplyLegacyAuditPolicy: $_"
    }
}

# Function to set Audit Credential Validation to Failure
function Set-AuditCredentialValidationFailure {
    try {
        # Run AuditPol to set the subcategory
        auditpol /set /subcategory:"Credential Validation" /failure:enable
        Write-Output "Successfully configured: Audit Credential Validation - Failure."
    } catch {
        Write-Error "Failed to configure Audit Credential Validation: $_"
    }
}

# Main Execution
Enable-ForceAuditPolicyOverride
Set-AuditCredentialValidationFailure
