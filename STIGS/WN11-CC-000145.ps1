<#
.SYNOPSIS
This PowerShell script ensures that Windows 11 enforces the STIG requirement for WN11-CC-000145 by creating (if needed) the registry path under HKLM\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51 and setting the DCSettingIndex DWORD value to 1. This enables the policy that requires a password when the computer wakes from sleep on battery power, improving physical security and ensuring compliance with STIG password-on-wake requirements.
.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000145
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000145/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-CC-000145.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-CC-000145 - Require password on wake (DC/battery)

Write-Host "Applying STIG: Require password on wake (Battery)..." -ForegroundColor Cyan

$path = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"

# Ensure registry path exists
New-Item -Path $path -Force | Out-Null

# Set required value
New-ItemProperty `
    -Path $path `
    -Name "DCSettingIndex" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

# Verification
$value = Get-ItemProperty -Path $path -Name "DCSettingIndex" -ErrorAction SilentlyContinue

Write-Host "`n--- Verification ---" -ForegroundColor Yellow
$value.DCSettingIndex

if ($value.DCSettingIndex -eq 1) {
    Write-Host "`nPASS: DCSettingIndex is set to 1 (Enabled)" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Setting not configured correctly" -ForegroundColor Red
}
