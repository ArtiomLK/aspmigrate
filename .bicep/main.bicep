targetScope = 'subscription'

var prefix = 'wplan'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep${prefix}'
  location: deployment().location
}

module vnetDeploy 'vnet.bicep' = {
  name: 'vnetDeploy${prefix}'
  scope: rg
}

module aseDeploy 'ase.bicep' = {
  name: 'aseDeploy${prefix}'
  scope: rg
  params: {
    aseName: 'asev3lk${prefix}'
    snetId: vnetDeploy.outputs.snetId
    aseZoneRedundancy: true
  }
}

module asePlan 'plan.bicep' = {
  name: 'asePlanDeploy${prefix}'
  scope: rg
  params: {
    appServicePlanName: 'asePlan${prefix}'
    appServicePlanKind: 'windows'
    hostingEnvironmentId: aseDeploy.outputs.asePlanId
  }
}

module siteDeploy 'site.bicep' = {
  name: 'siteDeploy${prefix}'
  scope: rg
  params: {
    appPlanId: asePlan.outputs.planId
    namePrefix: 'aspnet${prefix}'
    dockerImage: 'nginxdemos/hello'
    dockerImageTag: 'latest'
  }
}
