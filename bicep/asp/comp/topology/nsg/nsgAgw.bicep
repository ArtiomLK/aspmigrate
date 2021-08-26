param snetAGWAddr string
param nsgName string

resource nsgAgw 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: nsgName
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'AllowGatewayManagerInbound'
        properties: {
          description: 'Allow Gateway Manager Inbound administrative traffic'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '65200-65535'
          sourceAddressPrefix: 'GatewayManager'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowWebToAppGatewayInbound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: snetAGWAddr
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '80'
            '443'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

output id string = nsgAgw.id
