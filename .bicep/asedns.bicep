@secure()
param resolutionVnetId string
resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: 'name'
  location: 'global'
  properties: {
    zoneType: 'Private'
    resolutionVirtualNetworks: [
      {
        id: resolutionVnetId
      }
    ]
  }
}
