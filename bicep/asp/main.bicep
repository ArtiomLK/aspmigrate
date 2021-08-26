targetScope = 'subscription'

param appName string = 'plan'
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
param snetAseNameP string = 'snet-ase-${suffix}'
param snetAseAddrP string = '10.10.2.0/24'

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
    snetAseNameP: snetAseNameP
    snetAseAddrP: snetAseAddrP
  }
}
