<#
.SYNOPSIS

This PowerShell script ensures Windows 11 enforces the STIG requirement by creating or updating the registry value DisablePasswordSaving under HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services and setting it to 1, which disables the ability to save Remote Desktop credentials. This improves security by preventing stored RDP passwords while leaving all other existing registry values in that key unchanged..NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000270
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000270/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-CC-000270.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-CC-000270 - Do not allow passwords to be saved (RDP)

Write-Host "Applying STIG: Disable saved Remote Desktop passwords..." -ForegroundColor Cyan

$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

# Ensure registry path exists
New-Item -Path $path -Force | Out-Null

# Set required value
New-ItemProperty `
    -Path $path `
    -Name "DisablePasswordSaving" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

# Verification
$value = Get-ItemProperty -Path $path -Name "DisablePasswordSaving" -ErrorAction SilentlyContinue

Write-Host "`n--- Verification ---" -ForegroundColor Yellow
$value.DisablePasswordSaving

if ($value.DisablePasswordSaving -eq 1) {
    Write-Host "`nPASS: RDP password saving is disabled" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Setting not correctly configured" -ForegroundColor Red
}
