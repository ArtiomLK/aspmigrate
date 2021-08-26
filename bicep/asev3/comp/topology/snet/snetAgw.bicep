param snetName string
param snetAddr string
param nsgId string

resource snetDeployment 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: snetName
  properties: {
    addressPrefix: snetAddr
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

output id string = snetDeployment.id
