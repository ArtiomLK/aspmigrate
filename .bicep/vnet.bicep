param nsgAgwId string

var vnet_addr_pre1 = '10'
var vnet_addr_pre2 = '0'
var vnet_addr_pre = '${vnet_addr_pre1}.${vnet_addr_pre2}'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet-ase'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '${vnet_addr_pre}.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet-ase'
        properties: {
          addressPrefix: '${vnet_addr_pre}.0.0/24'
          delegations: [
            {
              name: 'Microsoft.Web.hostingEnvironments'
              properties: {
                serviceName: 'Microsoft.Web/hostingEnvironments'
              }
            }
          ]
        }
      }
      {
        name: 'snet-agw'
        properties: {
          addressPrefix: '${vnet_addr_pre}.1.0/24'
          networkSecurityGroup: {
            id: nsgAgwId
          }
        }
      }
      {
        name: 'snet-vmtest'
        properties: {
          addressPrefix: '${vnet_addr_pre}.2.0/24'
        }
      }
    ]
  }
}

output id string = virtualNetwork.id
output snetId string = virtualNetwork.properties.subnets[0].id
output snetAgwId string = virtualNetwork.properties.subnets[1].id
