resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'pip-agw'
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

output pipId string = publicIPAddress.id
