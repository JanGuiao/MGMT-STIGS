<#
.SYNOPSIS
This PowerShell script makes the system STIG-compliant by creating the required registry key (HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization) if it does not already exist, then creating or updating the NoLockScreenCamera DWORD value and setting it to 1. This enforces the policy that disables camera access on the lock screen, which is the required configuration for WN11-CC-000005.

.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000005
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000005/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-CC-000005.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-CC-000005 - Disable Lock Screen Camera

Write-Host "Applying STIG: Disable Lock Screen Camera..." -ForegroundColor Cyan

$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create registry path if it doesn't exist
New-Item -Path $path -Force | Out-Null

# Set required value
New-ItemProperty `
    -Path $path `
    -Name "NoLockScreenCamera" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

# Verification
$value = Get-ItemProperty -Path $path -Name "NoLockScreenCamera" -ErrorAction SilentlyContinue

Write-Host "`n--- Verification ---" -ForegroundColor Yellow
$value.NoLockScreenCamera

if ($value.NoLockScreenCamera -eq 1) {
    Write-Host "`nPASS: NoLockScreenCamera is set to 1" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Registry value not correctly configured" -ForegroundColor Red
}
