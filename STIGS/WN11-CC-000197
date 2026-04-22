<#
.SYNOPSIS
This script ensures Windows 11 disables Microsoft consumer experiences by creating or updating the Cloud Content policy registry key and setting DisableWindowsConsumerFeatures to 1, enforcing STIG WN11-CC-000197 and preventing consumer-related Windows suggestions and promotions.
.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000197/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-CC-000197.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-CC-000197 - Turn off Microsoft consumer experiences

Write-Host "Applying STIG: Disable Microsoft Consumer Features..." -ForegroundColor Cyan

$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"

# Ensure registry path exists
New-Item -Path $path -Force | Out-Null

# Set required value
New-ItemProperty `
    -Path $path `
    -Name "DisableWindowsConsumerFeatures" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

# Verification
$value = Get-ItemProperty -Path $path -Name "DisableWindowsConsumerFeatures" -ErrorAction SilentlyContinue

Write-Host "`n--- Verification ---" -ForegroundColor Yellow
$value.DisableWindowsConsumerFeatures

if ($value.DisableWindowsConsumerFeatures -eq 1) {
    Write-Host "`nPASS: Consumer features are disabled" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Setting not correctly configured" -ForegroundColor Red
}
