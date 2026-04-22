<#
.SYNOPSIS
This PowerShell script ensures that Windows 11 is configured to log failed registry access attempts by enabling Audit Registry (Failure) in the system’s Advanced Audit Policy. This supports STIG compliance by improving visibility into unauthorized or unsuccessful registry activity.
.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-WN11-AC-WN11-AU-000589
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000589/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-AU-000589.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-AU-000589 - Audit Registry (Failure)

Write-Host "Enabling Audit Registry (Failure)..." -ForegroundColor Cyan

# Enable FAILURE auditing for Registry access
auditpol /set /subcategory:"Registry" /success:disable /failure:enable | Out-Null

# Force policy refresh
gpupdate /force | Out-Null

Start-Sleep -Seconds 2

# Verification
$audit = auditpol /get /subcategory:"Registry"

Write-Host "`n--- Verification Output ---" -ForegroundColor Yellow
$audit

if ($audit -match "Registry.*Failure\s+Enabled") {
    Write-Host "`nPASS: Audit Registry is correctly configured for Failure" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Audit Registry is NOT configured for Failure" -ForegroundColor Red
}

Write-Host "`nNOTE: GPEDIT may still show 'Not Configured' even when auditpol is correct." -ForegroundColor DarkYellow
