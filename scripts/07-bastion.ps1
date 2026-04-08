# ============================================================
# AZ-500 Lab — 07-bastion.ps1
# Step 17, 18 — Deploy Azure Bastion
# Run 01-variables.ps1 first before running this script!
# ============================================================

if (-not $BAS_NAME) {
    Write-Host "ERROR: Variables not loaded! Run . ./01-variables.ps1 first." -ForegroundColor Red
    exit
}

# Create Bastion Public IP
Write-Host "Creating Bastion public IP..." -ForegroundColor Cyan
az network public-ip create --name $BAS_PIP --resource-group $RG --location $LOCATION --sku Standard --allocation-method Static
Write-Host "Public IP created." -ForegroundColor Green

# Deploy Bastion (takes ~5 min)
Write-Host ""
Write-Host "Deploying Azure Bastion (this takes ~5 minutes)..." -ForegroundColor Cyan
az network bastion create --name $BAS_NAME --resource-group $RG --location $LOCATION --vnet-name $HUB_VNET --public-ip-address $BAS_PIP --sku Basic
Write-Host "Bastion deployed." -ForegroundColor Green

# Verify
Write-Host ""
Write-Host "=== Bastion Status ===" -ForegroundColor Cyan
az network bastion show --name $BAS_NAME --resource-group $RG --query "{State:provisioningState, SKU:sku.name}"
Write-Host ""
Write-Host "Next step: Run 08-cleanup.ps1 when done with the lab." -ForegroundColor Yellow
