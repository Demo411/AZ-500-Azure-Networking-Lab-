# ============================================================
# AZ-500 Lab — 03-peering.ps1
# Step 7 & 8 — VNet Peering (Hub to Spoke and Spoke to Hub)
# Run 01-variables.ps1 first before running this script!
# ============================================================

if (-not $HUB_VNET) {
    Write-Host "ERROR: Variables not loaded! Run . ./01-variables.ps1 first." -ForegroundColor Red
    exit
}

# Get Spoke VNet ID
Write-Host "Getting Spoke VNet ID..." -ForegroundColor Cyan
$SPOKE_ID = az network vnet show --name $SPOKE_VNET --resource-group $RG --query id --output tsv

# Peer Hub to Spoke
Write-Host "Peering Hub to Spoke..." -ForegroundColor Cyan
az network vnet peering create --name "hub-to-spoke" --resource-group $RG --vnet-name $HUB_VNET --remote-vnet $SPOKE_ID --allow-vnet-access --allow-forwarded-traffic
Write-Host "Hub to Spoke peering done." -ForegroundColor Green

# Get Hub VNet ID
Write-Host "Getting Hub VNet ID..." -ForegroundColor Cyan
$HUB_ID = az network vnet show --name $HUB_VNET --resource-group $RG --query id --output tsv

# Peer Spoke to Hub
Write-Host "Peering Spoke to Hub..." -ForegroundColor Cyan
az network vnet peering create --name "spoke-to-hub" --resource-group $RG --vnet-name $SPOKE_VNET --remote-vnet $HUB_ID --allow-vnet-access --allow-forwarded-traffic
Write-Host "Spoke to Hub peering done." -ForegroundColor Green

# Verify
Write-Host ""
Write-Host "=== Peering Status ===" -ForegroundColor Cyan
az network vnet peering list --vnet-name $HUB_VNET --resource-group $RG --output table
Write-Host ""
Write-Host "Next step: Run 04-asgs.ps1" -ForegroundColor Yellow
