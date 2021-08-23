param aseName string
resource dnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: '${aseName}.appserviceenvironment.net'
  location: 'global'
  properties: {}
}

output name string = dnsZone.name
