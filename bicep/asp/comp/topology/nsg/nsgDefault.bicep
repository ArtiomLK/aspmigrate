resource nsgDefault 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'nsg-default'
  location: resourceGroup().location
  properties: {}
}

output id string = nsgDefault.id
