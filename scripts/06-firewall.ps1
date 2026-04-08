# ============================================================
# AZ-500 Lab — 06-firewall.ps1
# Step 13, 14, 15 — Deploy Azure Firewall
# Run 01-variables.ps1 first before running this script!
# ============================================================

if (-not $FW_NAME) {
    Write-Host "ERROR: Variables not loaded! Run . ./01-variables.ps1 first." -ForegroundColor Red
    exit
}

# Create Firewall Public IP
Write-Host "Creating Firewall public IP..." -ForegroundColor Cyan
az network public-ip create --name $FW_PIP --resource-group $RG --location $LOCATION --sku Standard --allocation-method Static
Write-Host "Public IP created." -ForegroundColor Green

# Deploy Firewall (takes 5-7 min)
Write-Host ""
Write-Host "Deploying Azure Firewall (this takes 5-7 minutes)..." -ForegroundColor Cyan
az network firewall create --name $FW_NAME --resource-group $RG --location $LOCATION --tier Standard
Write-Host "Firewall deployed." -ForegroundColor Green

# Attach IP config
Write-Host ""
Write-Host "Attaching IP config to Firewall..." -ForegroundColor Cyan
az network firewall ip-config create --firewall-name $FW_NAME --resource-group $RG --name "fw-ipconfig" --public-ip-address $FW_PIP --vnet-name $HUB_VNET
Write-Host "IP config attached." -ForegroundColor Green

# Add outbound network rule
Write-Host ""
Write-Host "Adding outbound rule (HTTP/HTTPS only)..." -ForegroundColor Cyan
az network firewall network-rule create --firewall-name $FW_NAME --resource-group $RG --collection-name "AllowOutbound" --priority 100 --action Allow --name "Allow-HTTP-HTTPS" --protocols Tcp --source-addresses "10.1.0.0/16" --destination-addresses "*" --destination-ports 80 443
Write-Host "Outbound rule added." -ForegroundColor Green

# Verify
Write-Host ""
Write-Host "=== Firewall Status ===" -ForegroundColor Cyan
az network firewall show --name $FW_NAME --resource-group $RG --query "provisioningState"
Write-Host ""
Write-Host "Next step: Run 06b-udr.ps1" -ForegroundColor Yellow
