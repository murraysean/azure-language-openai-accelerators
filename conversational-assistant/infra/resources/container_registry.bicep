@description('Name of Container Registry resource.')
param name string = 'acr${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

resource container_registry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  properties: {
    adminUserEnabled: false
    publicNetworkAccess: 'Disabled'
  }
  sku: {
    name: 'Basic'
  }
}

output name string = container_registry.name
