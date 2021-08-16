param location string = resourceGroup().location

param appServicePlanName string
param appServicePlanKind string = 'linux'
param appServicePlanSku object = {
  Name: 'I1v2'
  tier: 'IsolatedV2'
}
param appServicePlanWorkerCount int = 3
param appServicePlanWorkerSize int = 6
param hostingEnvironmentId string = ''

var hostingEnvironmentProfile = {
  id: hostingEnvironmentId
}

resource appPlan 'Microsoft.Web/serverfarms@2021-01-01' = {
  kind: appServicePlanKind
  name: appServicePlanName
  location: location
  properties: {
    hostingEnvironmentProfile: empty(hostingEnvironmentId) ? json('null') : hostingEnvironmentProfile
    perSiteScaling: false
    reserved: false
    targetWorkerCount: appServicePlanWorkerCount
    targetWorkerSizeId: appServicePlanWorkerSize
  }
  sku: appServicePlanSku
}

output planId string = appPlan.id
