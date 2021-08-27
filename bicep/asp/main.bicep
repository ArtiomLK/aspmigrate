targetScope = 'subscription'

param appName string = 'asp'
param env string = 'prod'
param tags object = {
  app: appName
  env: env
}
param suffix string = '${appName}-${env}'

// topology
// vNet
param vnetIdP string = ''
param vnetNameP string = 'vnet-${suffix}'
param vnetAddrP string = '10.10.0.0/16'

// AGW
param snetAgwNameP string = 'snet-agw-${suffix}'
param snetAgwAddrP string = '10.10.1.0/24'
// AGW NSG
param nsgAgwNameP string = 'nsg-agw-${suffix}'

// PE
param snetPeNameP string = 'snet-pe-${suffix}'
param snetPeAddrP string = '10.10.2.0/24'

// Web Appss
// ASP
param aspName string = 'asp-${suffix}'
param aspKind string = 'windows'
param aspSku string = 'P2v3'
// App
param siteName string = 'site-${suffix}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${suffix}'
  tags: tags
  location: deployment().location
}

module topologyDeploy 'comp/topology/topology.bicep' = {
  name: 'topology-deployment'
  scope: rg
  params: {
    appName: appName
    env: env
    tags: tags
    suffix: suffix
    // vNet
    vnetIdP: vnetIdP
    vnetNameP: vnetNameP
    vnetAddrP: vnetAddrP
    // AGW
    snetAgwNameP: snetAgwNameP
    snetAgwAddrP: snetAgwAddrP
    // AGW - NSG
    nsgAgwNameP: nsgAgwNameP
    // PE
    snetPeNameP: snetPeNameP
    snetPeAddrP: snetPeAddrP
  }
}

module aspDeploy 'comp/asp/asp.bicep' = {
  name: 'asp-deployment'
  scope: rg
  params: {
    aspName: aspName
    aspKind: aspKind
    aspSku: aspSku
  }
}

module siteDeploy 'comp/web/app.bicep' = {
  name: 'siteDeploy'
  scope: rg
  params: {
    siteName: siteName
    aseId: aspDeploy.outputs.id
  }
}
