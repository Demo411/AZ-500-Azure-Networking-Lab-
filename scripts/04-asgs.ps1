# ============================================================
# AZ-500 Lab — 04-asgs.ps1
# Step 9 — Create Application Security Groups
# Run 01-variables.ps1 first before running this script!
# ============================================================

if (-not $ASG_WEB) {
    Write-Host "ERROR: Variables not loaded! Run . ./01-variables.ps1 first." -ForegroundColor Red
    exit
}

Write-Host "Creating ASGs..." -ForegroundColor Cyan

az network asg create --name $ASG_WEB --resource-group $RG --location $LOCATION
Write-Host "Created: $ASG_WEB" -ForegroundColor Green

az network asg create --name $ASG_APP --resource-group $RG --location $LOCATION
Write-Host "Created: $ASG_APP" -ForegroundColor Green

az network asg create --name $ASG_DB --resource-group $RG --location $LOCATION
Write-Host "Created: $ASG_DB" -ForegroundColor Green

Write-Host ""
az network asg list --resource-group $RG --output table
Write-Host ""
Write-Host "Next step: Run 05-nsg.ps1" -ForegroundColor Yellow
