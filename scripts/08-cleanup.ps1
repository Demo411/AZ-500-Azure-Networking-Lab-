# ============================================================
# AZ-500 Lab — 08-cleanup.ps1
# Step 20 — Delete all resources
# Run 01-variables.ps1 first before running this script!
# ============================================================

if (-not $RG) {
    Write-Host "ERROR: Variables not loaded! Run . ./01-variables.ps1 first." -ForegroundColor Red
    exit
}

Write-Host "WARNING: This will delete ALL resources in $RG" -ForegroundColor Red
Write-Host "This includes the Firewall, Bastion, VMs, VNets, NSG, ASGs and Route Tables." -ForegroundColor Red
Write-Host ""

# Delete resource group
Write-Host "Deleting resource group: $RG ..." -ForegroundColor Cyan
az group delete --name $RG --yes --no-wait
Write-Host "Deletion started in background." -ForegroundColor Green

Write-Host ""
Write-Host "Run the command below in a few minutes to confirm it is gone:" -ForegroundColor Yellow
Write-Host "az group show --name $RG" -ForegroundColor Yellow
