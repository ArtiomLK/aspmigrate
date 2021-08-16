param aseName string
param aseZoneRedundancy bool = true
param snetId string

resource ase 'Microsoft.Web/hostingEnvironments@2021-01-15' = {
  name: aseName
  location: resourceGroup().location
  kind: 'ASEV3'
  properties: {
    dnsSuffix: '${aseName}.appserviceenvironment.net'
    internalLoadBalancingMode: 'Web, Publishing'
    virtualNetwork: {
      id: snetId
    }
    zoneRedundant: aseZoneRedundancy
  }
  tags: {
    'ase-version': 'v3'
  }
}

output asePlanId string = ase.id
