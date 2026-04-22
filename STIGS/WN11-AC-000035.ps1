<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 enforces a minimum password length of 14 characters, strengthening password complexity requirements and reducing the risk of brute-force and weak password attacks in compliance with STIG standards.
.NOTES
    Author          : Jan Guiao
    LinkedIn        : linkedin.com/in/JanGuiao/
    GitHub          : github.com/JanGuiao
    Date Created    : 2026-04-21
    Last Modified   : 2026-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000035
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AC-000035/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\j4n\Desktop> C:\Users\j4n\Desktop\WN11-AC-000035.ps1
#>

# YOUR CODE GOES HERE

# STIG - Minimum Password Length (>= 14)

$requiredLength = 14

Write-Host "Setting Minimum Password Length to $requiredLength..." -ForegroundColor Cyan

# Apply setting
net accounts /minpwlen:$requiredLength | Out-Null

# Verify setting
$policy = net accounts | Select-String "Minimum password length"

if ($policy -match "\d+") {
    $current = [int]($matches[0])

    if ($current -ge $requiredLength) {
        Write-Host "PASS: Minimum password length is $current" -ForegroundColor Green
    } else {
        Write-Host "FAIL: Minimum password length is $current (expected $requiredLength)" -ForegroundColor Red
    }
} else {
    Write-Host "Unable to verify minimum password length setting." -ForegroundColor Yellow
}
