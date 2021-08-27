param siteName string
param aseId string

resource site 'Microsoft.Web/sites@2021-01-15' = {
  name: siteName
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: []
      netFrameworkVersion: 'v4.8'
      alwaysOn: true
    }
    serverFarmId: aseId
    clientAffinityEnabled: true
  }
}

output siteUrl string = site.properties.hostNames[0]
