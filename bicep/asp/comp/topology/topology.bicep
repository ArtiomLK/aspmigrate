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

// sNet - AGW
param snetAgwNameP string = 'snet-agw-${suffix}'
param snetAgwAddrP string = '10.10.1.0/24'
// sNet - AGW - NSG
param nsgAgwNameP string = 'nsg-agw-${suffix}'

// sNet - PE
param snetAseNameP string = 'snet-ase-${suffix}'
param snetAseAddrP string = '10.10.2.0/24'

// ------------------------------------------------------------------------------------------------
// vNet
module mainVnetDepoyment 'vnet/vnet.bicep' = if (empty(vnetIdP)) {
  name: 'mainVnetDepoyment'
  params: {
    tags: tags
    vnetNameP: vnetNameP
    vnetAddrP: vnetAddrP
  }
}

// ------------------------------------------------------------------------------------------------
// NSG - Default
module nsgDefaultDeploy 'nsg/nsgDefault.bicep' = {
  name: 'nsg-default-deployment'
}

// ------------------------------------------------------------------------------------------------
// AGW
// AGW - NSG
module nsgAgwDeloy 'nsg/nsgAgw.bicep' = if (empty(vnetIdP)) {
  name: 'nsg-agw-deployment'
  params: {
    snetAGWAddr: snetAgwAddrP
    nsgName: nsgAgwNameP
  }
}
// AGW - sNet
module snetAgwDeploy 'snet/snetAgw.bicep' = if (empty(vnetIdP)) {
  name: 'snet-agw-deployment'
  params: {
    snetName: '${vnetNameP}/${snetAgwNameP}'
    snetAddr: snetAgwAddrP
    nsgId: nsgAgwDeloy.outputs.id
  }
}

// ------------------------------------------------------------------------------------------------
// PE
// PE - sNet
module snetAseDeploy 'snet/snetAse.bicep' = if (empty(vnetIdP)) {
  name: 'snet-ase-deployment'
  params: {
    snetName: '${vnetNameP}/${snetAseNameP}'
    snetAddr: snetAseAddrP
    nsgId: nsgDefaultDeploy.outputs.id
  }
}
