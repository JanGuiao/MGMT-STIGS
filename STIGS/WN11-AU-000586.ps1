<#
.SYNOPSIS
This PowerShell script ensures that Windows 11 enables Audit Registry success events, allowing the system to log successful registry access attempts. This supports STIG compliance by improving visibility into object access activity and strengthening system auditing and forensic traceability.

.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-WN11-AC-000586
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000586/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n> C:\Users\j4n\Desktop\WN11-AU-000586.ps1
#>

# YOUR CODE GOES HERE

# STIG WN11-AU-000586 - Audit Registry (Success)

Write-Host "Applying STIG: Audit Registry = Success..." -ForegroundColor Cyan

# Step 1: Enable Advanced Audit Policy behavior
auditpol /set /category:* /success:enable /failure:disable | Out-Null

# Step 2: Explicitly enable Registry auditing (Success only)
auditpol /set /subcategory:"Registry" /success:enable /failure:disable | Out-Null

# Step 3: Force Group Policy refresh
gpupdate /force | Out-Null

Start-Sleep -Seconds 2

# Step 4: Verification (effective policy check)
$audit = auditpol /get /subcategory:"Registry"

Write-Host "`n--- Verification Output ---" -ForegroundColor Yellow
$audit

if ($audit -match "Registry\s+Success") {
    Write-Host "`nPASS: Audit Registry is correctly configured for Success" -ForegroundColor Green
} else {
    Write-Host "`nFAIL: Audit Registry is NOT configured correctly" -ForegroundColor Red
}

# Optional: display GPEDIT-related status hint
Write-Host "`nNOTE: GPEDIT may still show 'Not Configured' even when auditpol is correct." -Foregrou
