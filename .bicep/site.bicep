param appPlanId string
param namePrefix string
param location string = resourceGroup().location
param dockerImage string
param dockerImageTag string

resource namePrefix_site 'Microsoft.Web/sites@2021-01-15' = {
  name: '${namePrefix}site'
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index/docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOEKCER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      windowsFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
      netFrameworkVersion: 'v4.0'
      alwaysOn: true
    }
    serverFarmId: appPlanId
  }
}

output siteUrl string = namePrefix_site.properties.hostNames[0]
