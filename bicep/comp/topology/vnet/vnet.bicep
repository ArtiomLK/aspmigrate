param tags object
param vnetNameP string
param vnetAddrP string

resource vnetDeployed 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetNameP
  location: resourceGroup().location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddrP
      ]
    }
  }
}

output id string = vnetDeployed.id
