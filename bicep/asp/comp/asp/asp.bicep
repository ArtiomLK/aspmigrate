param aspName string
param aspKind string
param aspSku string

resource asp 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: aspName
  location: resourceGroup().location
  kind: aspKind
  sku: {
    name: aspSku
  }
}

output id string = asp.id
