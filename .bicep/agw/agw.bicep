param snetAgwId string
param pipId string

var apgwName = 'agw'
var frontendIPConfigurationsName = 'appGatewayFrontendIP'
var frontendPort80Name = 'appGatewayFrontendPort'
var appGatewayHttpListener = 'appGatewayHttpListener'
var appGatewayBackendPool = 'appGatewayBackendPool'
var appGatewayBackendHttpSettings = 'appGatewayBackendHttpSettings'

resource applicationGateway 'Microsoft.Network/applicationGateways@2021-02-01' = {
  name: apgwName
  location: resourceGroup().location
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
      capacity: 2
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          subnet: {
            id: snetAgwId
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: frontendIPConfigurationsName
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pipId
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: frontendPort80Name
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: appGatewayBackendPool
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: appGatewayBackendHttpSettings
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    httpListeners: [
      {
        name: appGatewayHttpListener
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', apgwName, frontendIPConfigurationsName)
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', apgwName, frontendPort80Name)
          }
          protocol: 'Http'
          sslCertificate: null
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', apgwName, appGatewayHttpListener)
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', apgwName, appGatewayBackendPool)
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', apgwName, appGatewayBackendHttpSettings)
          }
        }
      }
    ]
    enableHttp2: false
    webApplicationFirewallConfiguration: {
      enabled: true
      firewallMode: 'Prevention'
      ruleSetType: 'OWASP'
      ruleSetVersion: '3.1'
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
    }
  }
}
