# Migrate ASP Apps to Azure App Service Environment V3

## Resources

- App Service Environment V3 (ASE V3)
- App Service Plan (PLAN)
- App Service (app)
- Virtual Networks (vNet)
- Network Security Groups (NSG)

## Bicep Commands

| Command                                                  | Description |
| -------------------------------------------------------- | ----------- |
| `bicep build .\main.bicep`                               | -           |
| `az deployment sub create -l eastus2 -c -f .\main.bicep` | -           |
| `az bicep decompile --file main.json .\main.bicep`       | -           |

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
az deployment sub create -l "eastus2" -f .\main.bicep -n "aseDeploy" -c
```

---

### Clean up resources

```bash
az group delete -n "rg-name" -y
```

---

## Additional Resources

- HYBRID NETWORKING
- [MS | Docs | Dual-redundancy: active-active VPN gateways for both Azure and on-premises networks][1]
- ASE V3
- [MS | Docs | Announcing App Service Environment v3 GA][2]
- [MS | Docs | App Service pricing][3]
- [MS | Docs | App Service Environment overview][4]
- [Medium | Tutorial | Azure App Service Environment v3][5]

[1]: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable#dual-redundancy-active-active-vpn-gateways-for-both-azure-and-on-premises-networks
[2]: https://techcommunity.microsoft.com/t5/apps-on-azure/announcing-app-service-environment-v3-ga/ba-p/2517990
[3]: https://azure.microsoft.com/en-us/pricing/details/app-service/windows/
[4]: https://docs.microsoft.com/en-us/azure/app-service/environment/overview
[5]: https://medium.com/rwiankowski/azure-app-service-environment-v3-f29dd991df9b
