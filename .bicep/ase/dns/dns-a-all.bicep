@secure()
param privateDnsName string
param aseId string
resource symbolicname 'Microsoft.Network/privateDnsZones/A@2020-06-01' = {
  name: '${privateDnsName}/*'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: reference('${aseId}/configurations/networking', '2019-08-01').internalInboundIpAddresses[0]
      }
    ]
  }
}
