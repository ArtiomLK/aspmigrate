# Migrate ASP Apps to Azure App Service Plan

## Resources

- App Service Plan (ASP)
- App Service (app)
- Virtual Networks (vNet)
- Network Security Groups (NSG)

## Bicep Commands

| Command                                                | Description |
| ------------------------------------------------------ | ----------- |
| `bicep build .\main.bicep`                             | -           |
| `az deployment sub create -l eastus2 -c -f main.bicep` | -           |
| `az bicep decompile --file main.json .\main.bicep`     | -           |

---

## Instructions

```bash
# Connect to our azure subscription
# Login to azure
az login
# Display available subscriptions
az account list --output table
# Switch to the subscription where we want to work on
az account set --subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# Check whether we are on the right subscription
az account show --output table
# If using Git Bash avoid C:/Program Files/Git/ being appended to some resources IDs
export MSYS_NO_PATHCONV=1

# Replace
# location, rg, vnets addrs, snets addrs

### Trigger our deployment
# make sure to move to where the main.bicep file is with the command 'cd'
az deployment sub create -l "eastus2" -f main.bicep -n "aspDeploy" -c
```

---

### Clean up resources

```bash
az group delete -n "rg-name" -y
```

---

### Suggestions

- If you require VPN connection you should create a VPN Gateway Subnet, preferably use the last address of your vNet
  - If you already have a VPN in another vNet, just peer the vNets

[1]: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable#dual-redundancy-active-active-vpn-gateways-for-both-azure-and-on-premises-networks
