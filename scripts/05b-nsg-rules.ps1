# ============================================================
# AZ-500 Lab — 05b-nsg-rules.ps1
# Step 11 — Add Inbound Security Rules to the NSG
# Run 01-variables.ps1 first before running this script!
# ============================================================

# Safety check — make sure variables are loaded
if (-not $NSG_SPOKE) {
    Write-Host "ERROR: Variables not loaded! Run . .\01-variables.ps1 first." -ForegroundColor Red
    exit
}

# ------------------------------------------------------------
# Rule 1 — Allow Internet to Web tier (HTTP port 80 + HTTPS port 443)
# ------------------------------------------------------------
Write-Host "Adding Rule 1: Allow Internet to Web tier (ports 80 & 443)..." -ForegroundColor Cyan

az network nsg rule create `
    --nsg-name $NSG_SPOKE --resource-group $RG `
    --name "Allow-Internet-to-Web" --priority 100 `
    --direction Inbound --access Allow --protocol Tcp `
    --destination-port-ranges 80 443 `
    --destination-asgs $ASG_WEB `
    --source-address-prefixes Internet

Write-Host "Rule 1 added." -ForegroundColor Green

# ------------------------------------------------------------
# Rule 2 — Allow Web ASG to App ASG on port 8080
# ------------------------------------------------------------
Write-Host ""
Write-Host "Adding Rule 2: Allow Web tier to App tier (port 8080)..." -ForegroundColor Cyan

az network nsg rule create `
    --nsg-name $NSG_SPOKE --resource-group $RG `
    --name "Allow-Web-to-App" --priority 200 `
    --direction Inbound --access Allow --protocol Tcp `
    --destination-port-ranges 8080 `
    --source-asgs $ASG_WEB --destination-asgs $ASG_APP

Write-Host "Rule 2 added." -ForegroundColor Green

# ------------------------------------------------------------
# Rule 3 — Allow App ASG to DB ASG on port 1433 (SQL Server)
# ------------------------------------------------------------
Write-Host ""
Write-Host "Adding Rule 3: Allow App tier to DB tier (port 1433)..." -ForegroundColor Cyan

az network nsg rule create `
    --nsg-name $NSG_SPOKE --resource-group $RG `
    --name "Allow-App-to-DB" --priority 300 `
    --direction Inbound --access Allow --protocol Tcp `
    --destination-port-ranges 1433 `
    --source-asgs $ASG_APP --destination-asgs $ASG_DB

Write-Host "Rule 3 added." -ForegroundColor Green

# ------------------------------------------------------------
# Rule 4 — Deny everything else (catch-all at lowest priority)
# ------------------------------------------------------------
Write-Host ""
Write-Host "Adding Rule 4: Deny all other inbound traffic..." -ForegroundColor Cyan

az network nsg rule create `
    --nsg-name $NSG_SPOKE --resource-group $RG `
    --name "Deny-All-Inbound" --priority 4000 `
    --direction Inbound --access Deny --protocol "*" `
    --destination-port-ranges "*" `
    --source-address-prefixes "*" `
    --destination-address-prefixes "*"

Write-Host "Rule 4 added." -ForegroundColor Green

# ------------------------------------------------------------
# Verify — list all rules in the NSG
# ------------------------------------------------------------
Write-Host ""
Write-Host "=== All NSG Rules ===" -ForegroundColor Cyan
az network nsg rule list `
    --nsg-name $NSG_SPOKE --resource-group $RG `
    --output table

Write-Host ""
Write-Host "All inbound rules added successfully." -ForegroundColor Green
Write-Host "Next step: Run 05c-nsg-associate.ps1 to associate the NSG to Spoke subnets." -ForegroundColor Yellow
