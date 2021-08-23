param c object
param vnetP object

// Sanitized vnet Parameters 
var vnetPS = empty(vnetP) ? {
  name: ''
  addr1: 10
  addr2: 10
  addr3: 0
  addr4: 0
  addrBlock: 16
  addr: '10.10.0.0/16'
  snets: [
    {
      name: '' // leave like this if you want to use default values
      addr: '' // otherwise replace and add more objects such as { name: 'snetName' addr: 'x.y.z.0/24'}
    }
  ]
} : vnetP

var vnet = {
  name: empty(vnetPS.name) ? 'vnet-${c.prefix}' : vnetPS.name
  addr: empty(vnetPS.addr) ? '${vnetPS.addr1}.${vnetPS.addr2}.${vnetPS.addr3}.${vnetPS.addr4}/${vnetPS.addrBlock}' : vnetPS.addr
  snets: empty(vnetPS.snets[0].name) ? [
    {
      // hardcoded index 0 for agw addrs nsg rule
      name: 'snet-agw'
      addr: '${vnetPS.addr1}.${vnetPS.addr2}.2.0/24'
      nsg: {
        name: 'nsg-agw-${c.prefix}'
      }
    }
    {
      name: 'snet-ase'
      addr: '${vnetPS.addr1}.${vnetPS.addr2}.1.0/24'
      delegations: [
        {
          name: 'Microsoft.Web.hostingEnvironments'
          properties: {
            serviceName: 'Microsoft.Web/hostingEnvironments'
          }
        }
      ]
    }
    {
      name: 'snet-vm'
      addr: '${vnetPS.addr1}.${vnetPS.addr2}.3.0/24'
    }
  ] : vnetPS.snet
}

var snetApg = vnet.snets[0]
module nsgAgwDeploy 'nsg/nsg-agw.bicep' = {
  name: 'nsg-agw-deployment'
  params: {
    nsgName: snetApg.nsg.name
    snetAGWAddr: snetApg.addr
  }
}

module vnetDeploy 'vnet/vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    c: c
    vnet: vnet
  }
}
