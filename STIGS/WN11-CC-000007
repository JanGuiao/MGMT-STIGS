<#
.SYNOPSIS
This PowerShell script ensures that Windows 11 enforces the STIG requirement by creating (if necessary) the registry path under HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam and setting the Value entry to Deny, which blocks applications from accessing the webcam through Windows privacy controls when the device is not physically disabled or covered.
.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000007
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000007/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-CC-000007.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-CC-000007 - Deny Webcam Access

Write-Host "Applying STIG: Disable Webcam Access (Deny)..." -ForegroundColor Cyan

$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam"

# Ensure registry path exists
New-Item -Path $path -Force | Out-Null

# Set value to Deny
New-ItemProperty `
    -Path $path `
    -Name "Value" `
    -PropertyType String `
    -Value "Deny" `
    -Force | Out-Null

# Verification
$value = Get-ItemProperty -Path $path -Name "Value" -ErrorAction SilentlyContinue

Write-Host "`n--- Verification ---" -ForegroundColor Yellow
$value.Value

if ($value.Value -eq "Deny") {
    Write-Host "`nPASS: Webcam access is set to Deny" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Webcam access is not correctly configured" -ForegroundColor Red
}
