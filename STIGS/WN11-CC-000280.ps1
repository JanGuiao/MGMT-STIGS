<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 enforces a password history of at least 24 passwords, preventing users from reusing recent passwords and strengthening overall account security in compliance with STIG requirements.

.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000280
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000280/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-CC-000280.ps1
#>

# YOUR CODE GOES HERE


# STIG WN11-CC-000280 - Always prompt for password on RDP connection

Write-Host "Applying STIG: Always prompt for password on RDP..." -ForegroundColor Cyan

$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

# Ensure registry path exists
New-Item -Path $path -Force | Out-Null

# Set required value
New-ItemProperty `
    -Path $path `
    -Name "fPromptForPassword" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

# Verification
$value = Get-ItemProperty -Path $path -Name "fPromptForPassword" -ErrorAction SilentlyContinue

Write-Host "`n--- Verification ---" -ForegroundColor Yellow
$value.fPromptForPassword

if ($value.fPromptForPassword -eq 1) {
    Write-Host "`nPASS: RDP password prompt is enforced" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Setting not correctly configured" -ForegroundColor Red
}
