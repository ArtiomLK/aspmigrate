targetScope = 'subscription'

param appP string = 'wit'
param envP string = 'dev'
param prefixP string = '${appP}-${envP}'
param rgP string = 'rg-${prefixP}'

param tagsP object = {
  app: appP
  env: envP
}

param vnetP object = {}

// grouping everything into a single object
var c = {
  app: appP
  env: envP
  prefix: prefixP
  tags: tagsP
  rg: rgP
}

// = {
//   name: ''
//   addr1: 10
//   addr2: 10
//   addr3: 0
//   addr4: 0
//   addrBlock: 16
//   addr: '10.10.0.0/16'
//   snets: [
//     {
//       name: '' // leave like this if you want to use default values
//       addr: '' // otherwise replace and add more objects such as { name: 'snetName' addr: 'x.y.z.0/24'}
//     }
//   ]
// }

// var c = {
//   // grouping everything into a single object
//   app: app
//   env: env
//   prefix: prefix
//   tags: tags
//   rg: 'rg-${prefix}'
// vnet: {
//   name: empty(vnet.name) ? 'vnet-${prefix}' : vnet.name
//   addr: empty(vnet.addr) ? '${vnet.addr1}.${vnet.addr2}.${vnet.addr3}.${vnet.addr4}/${vnet.addrBlock}' : vnet.addr
//   snets: empty(vnet.snets[0].name) ? [
//     {
//       // hardcoded index 0 for agw addrs nsg rule
//       name: 'snet-agw'
//       addr: '${vnet.addr1}.${vnet.addr2}.2.0/24'
//       nsgFile: 'nsg-agw' //should we reference the file?
//     }
//     {
//       name: 'snet-ase'
//       addr: '${vnet.addr1}.${vnet.addr2}.1.0/24'
//       delegations: [
//         {
//           name: 'Microsoft.Web.hostingEnvironments'
//           properties: {
//             serviceName: 'Microsoft.Web/hostingEnvironments'
//           }
//         }
//       ]
//     }
//     {
//       name: 'snet-vm'
//       addr: '${vnet.addr1}.${vnet.addr2}.3.0/24'
//     }
//   ] : vnet.snet
// }
// }

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: c.rg
  tags: c.tags
  location: deployment().location
}

module topologyDeploy 'topology/topology.bicep' = {
  name: 'topology-deployment'
  scope: rg
  params: {
    c: c
    vnetP: vnetP
  }
}

// module vnetDeploy 'vnet/vnet.bicep' = {
//   name: 'vnetDeployment'
//   scope: rg
//   params: {
//     c: c
//   }
// }

// module nsgAgwDeploy 'agw/nsg-agw.bicep' = {
//   name: 'nsg-agw-deployment'
//   scope: rg
//   params: {
//     snetAGWAddr: vnet.addr
//   }
// }

// module pipAgwDeploy 'agw/pip-agw.bicep' = {
//   name: 'pip-apg-deployment'
//   scope: rg
// }

// module vnetDeploy 'vnet.bicep' = {
//   name: 'vnetDeploy${prefix}'
//   scope: rg
//   params: {
//     nsgAgwId: nsgAgwDeploy.outputs.nsgAgwId
//   }
// }

// module privateDnsDeploy 'ase/dns/private-dns-zone.bicep' = {
//   name: 'ase-dns-deployment'
//   scope: rg
//   params: {
//     aseName: aseName
//   }
// }

// module privateDnsAAllDeploy 'ase/dns/dns-a-all.bicep' = {
//   name: 'ase-dns-a-all-deployment'
//   scope: rg
//   params: {
//     privateDnsName: privateDnsDeploy.outputs.name
//     aseId: aseDeploy.outputs.aseId
//   }
// }

// module privateDnsAScmDeploy 'ase/dns/dns-a-scm.bicep' = {
//   name: 'ase-dns-a-scm-deployment'
//   scope: rg
//   params: {
//     privateDnsName: privateDnsDeploy.outputs.name
//     aseId: aseDeploy.outputs.aseId
//   }
// }

// module vnetDnsLinkDeploy 'ase/dns/vnet-dns-link.bicep' = {
//   name: 'vnet-dnslink-deployment'
//   scope: rg
//   params: {
//     privateDnsName: privateDnsDeploy.outputs.name
//     vnetId: vnetDeploy.outputs.id
//   }
// }

// module agwDeploy 'agw/agw.bicep' = {
//   name: 'agwDeploy${prefix}'
//   scope: rg
//   params: {
//     snetAgwId: vnetDeploy.outputs.snetAgwId
//     pipId: pipAgwDeploy.outputs.pipId
//   }
// }

// module aseDeploy 'ase.bicep' = {
//   name: 'aseDeploy${prefix}'
//   scope: rg
//   params: {
//     aseName: aseName
//     snetId: vnetDeploy.outputs.snetId
//     aseZoneRedundancy: true
//   }
// }

// module asePlan 'plan.bicep' = {
//   name: 'asePlanDeploy${prefix}'
//   scope: rg
//   params: {
//     appServicePlanName: 'asePlan${prefix}'
//     appServicePlanKind: 'windows'
//     hostingEnvironmentId: aseDeploy.outputs.aseId
//   }
// }

// module siteDeploy 'site.bicep' = {
//   name: 'siteDeploy${prefix}'
//   scope: rg
//   params: {
//     appPlanId: asePlan.outputs.planId
//     namePrefix: 'aspnet${prefix}'
//     dockerImage: 'nginxdemos/hello'
//     dockerImageTag: 'latest'
//   }
// }
