# ============================================================
# AZ-500 Lab — 01-variables.ps1
# Run this block FIRST at the start of every new session.
# Variables do not persist between PowerShell sessions.
# ============================================================

# === RESOURCE GROUP & LOCATION ===
$RG       = "az500-lab-rg"
$LOCATION = "centralus"

# === HUB VNET ===
$HUB_VNET   = "hub-vnet"
$HUB_PREFIX = "10.0.0.0/16"
$FW_SUBNET  = "AzureFirewallSubnet"   # exact name required by Azure
$BAS_SUBNET = "AzureBastionSubnet"    # exact name required by Azure
$MGMT_SUB   = "mgmt-subnet"

# === SPOKE VNET ===
$SPOKE_VNET   = "spoke-vnet"
$SPOKE_PREFIX = "10.1.0.0/16"
$WEB_SUB      = "web-subnet"
$APP_SUB      = "app-subnet"
$DB_SUB       = "db-subnet"

# === SECURITY ===
$NSG_SPOKE = "nsg-spoke"
$ASG_WEB   = "asg-web"
$ASG_APP   = "asg-app"
$ASG_DB    = "asg-db"

# === FIREWALL & BASTION ===
$FW_NAME  = "lab-firewall"
$FW_PIP   = "fw-pip"
$BAS_NAME = "lab-bastion"
$BAS_PIP  = "bas-pip"

# === ROUTE TABLE ===
$RT_NAME = "hub-to-fw-rt"

# ============================================================
# Confirmation — prints all variables so you can verify
# ============================================================
Write-Host ""
Write-Host "=== AZ-500 Lab Variables Loaded ===" -ForegroundColor Cyan
Write-Host "Resource Group : $RG"
Write-Host "Location       : $LOCATION"
Write-Host "Hub VNet       : $HUB_VNET  ($HUB_PREFIX)"
Write-Host "Spoke VNet     : $SPOKE_VNET ($SPOKE_PREFIX)"
Write-Host "Firewall       : $FW_NAME"
Write-Host "Bastion        : $BAS_NAME"
Write-Host "NSG            : $NSG_SPOKE"
Write-Host "ASGs           : $ASG_WEB, $ASG_APP, $ASG_DB"
Write-Host "Route Table    : $RT_NAME"
Write-Host ""
Write-Host "All variables set. You are ready to run the next script." -ForegroundColor Green
