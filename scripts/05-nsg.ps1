# ============================================================
# AZ-500 Lab — 05-nsg.ps1
# Step 10 — Create the Network Security Group (NSG)
# Run 01-variables.ps1 first before running this script!
# ============================================================

# Safety check — make sure variables are loaded
if (-not $NSG_SPOKE) {
    Write-Host "ERROR: Variables not loaded! Run . .\01-variables.ps1 first." -ForegroundColor Red
    exit
}

Write-Host "Creating NSG: $NSG_SPOKE ..." -ForegroundColor Cyan

az network nsg create `
    --name $NSG_SPOKE `
    --resource-group $RG `
    --location $LOCATION

Write-Host ""
Write-Host "NSG '$NSG_SPOKE' created successfully." -ForegroundColor Green
Write-Host "Next step: Run 05b-nsg-rules.ps1 to add inbound security rules." -ForegroundColor Yellow
