# AZ-500-Azure-Networking-Lab- Hub-and-Spoke Security Architecture

A hands-on Azure security lab covering Network Security Groups, Application Security Groups, VNet Peering, Azure Firewall, and Azure Bastion in a Hub-and-Spoke topology.
 
===========================================================
WHAT THIS LAB DEMONSTRATES
===========================================================
 
This lab builds a production-style secure network on Azure that maps directly to the AZ-500: Microsoft Azure Security Technologies exam domains.
 
Component              | Security Concept                          | AZ-500 Domain
-----------------------|-------------------------------------------|-------------------
NSG + ASG Rules        | Traffic segmentation between tiers        | Network Security
Azure Firewall + UDR   | Outbound traffic inspection & control     | Perimeter Security
Azure Bastion          | Zero-trust VM access (no public RDP)      | Zero-Trust Access
VNet Peering           | Hub-and-Spoke isolation                   | Network Segmentation
Attack Simulations     | Prove every control works                 | Threat Defense
 
===========================================================
ARCHITECTURE
===========================================================
 
                        Internet
                           |
                    [Azure Firewall]
                    10.0.1.0/26
                           |
              Hub VNet (10.0.0.0/16)
                  [Azure Bastion]     10.0.2.0/27
                  [Mgmt Subnet]       10.0.3.0/24
                           |
                      VNet Peering
                           |
              Spoke VNet (10.1.0.0/16)
                  [Web Subnet]  ASG-Web   10.1.1.0/24
                  [App Subnet]  ASG-App   10.1.2.0/24
                  [DB Subnet]   ASG-DB    10.1.3.0/24
 
NSG Traffic Flow:
  Internet  ---(80/443)--->  Web Tier
  Web Tier  ---(8080)----->  App Tier
  App Tier  ---(1433)----->  DB Tier
  Everything else ---------- DENIED
 
===========================================================
STEPS & SCRIPT ORDER
===========================================================
 
Run each script in order. Always dot-source the variables script first in every new session:
 
. ./scripts/01-variables.ps1        Load all variables — run this FIRST every session
./scripts/02-vnets.ps1              Create Hub and Spoke VNets
./scripts/03-peering.ps1            Peer Hub and Spoke in both directions
./scripts/04-asgs.ps1               Create Application Security Groups
./scripts/05-nsg.ps1                Create the Network Security Group
./scripts/05b-nsg-rules.ps1         Add inbound security rules
./scripts/06-firewall.ps1           Deploy Azure Firewall 
./scripts/06b-udr.ps1               Create UDR and route Spoke traffic through Firewall
./scripts/07-bastion.ps1            Deploy Azure Bastion
./scripts/08-cleanup.ps1            DELETE everything when done
 
===========================================================
RESOURCE SUMMARY
===========================================================
 
Component            Name                   CIDR / SKU
Hub VNet             hub-vnet               10.0.0.0/16
Firewall Subnet      AzureFirewallSubnet    10.0.1.0/26
Bastion Subnet       AzureBastionSubnet     10.0.2.0/27
Mgmt Subnet          mgmt-subnet            10.0.3.0/24
Spoke VNet           spoke-vnet             10.1.0.0/16
Web Subnet           web-subnet             10.1.1.0/24
App Subnet           app-subnet             10.1.2.0/24
DB Subnet            db-subnet              10.1.3.0/24
Azure Firewall       lab-firewall           Standard SKU
Azure Bastion        lab-bastion            Basic SKU
 
===========================================================
ATTACK SIMULATIONS
===========================================================
 
Attack                              Control That Stops It                     Expected Result
Internet to DB direct (port 1433)   NSG Deny-All-Inbound (priority 4000)     Unreachable
Web VM to DB lateral (port 1433)    ASG rule - source must be asg-app         Unreachable
Outbound exfiltration (port 22)     Azure Firewall + UDR (80/443 only)       Unreachable
RDP brute force (port 3389)         No public IP + Bastion only               No attack surface
Legitimate web traffic (80/443)     Passes NSG + Firewall                     Reachable
 
===========================================================
AUTHOR
===========================================================
 
Built as part of AZ-500 exam preparation at Nova Southeastern University (NSU).
 
