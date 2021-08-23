param c object

resource vnetDeployed 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: c.vnet.name
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        c.vnet.addr
      ]
    }
    subnets: [for snet in c.vnet.snets: {
      name: snet.name
      properties: {
        addressPrefix: snet.addr
        delegations: contains(snet, 'delegations') ? snet.delegations : []
      }
    }]
    // {
    //   name: 'snet-ase'
    //   properties: {
    //     addressPrefix: '${vnet_addr_pre}.0.0/24'
    //     delegations: [
    //       {
    //         name: 'Microsoft.Web.hostingEnvironments'
    //         properties: {
    //           serviceName: 'Microsoft.Web/hostingEnvironments'
    //         }
    //       }
    //     ]
    //   }
    // }
    // {
    //   name: 'snet-agw'
    //   properties: {
    //     addressPrefix: '${vnet_addr_pre}.1.0/24'
    //     networkSecurityGroup: {
    //       id: nsgAgwId
    //     }
    //   }
    // }
    // {
    //   name: 'snet-vmtest'
    //   properties: {
    //     addressPrefix: '${vnet_addr_pre}.2.0/24'
    //   }
    // }
  }
}

// output id string = virtualNetwork.id
// output snetId string = virtualNetwork.properties.subnets[0].id
// output snetAgwId string = virtualNetwork.properties.subnets[1].id
output vnetDeployed object = vnetDeployed
