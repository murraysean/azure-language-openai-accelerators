@description('Name of AI Search resource.')
param name string = 'srch-${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of Storage Account resource')
param storage_account_name string

resource storage_account 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storage_account_name
}

@description('Search Service resource.')
resource search_service 'Microsoft.Search/searchServices@2023-11-01' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    disableLocalAuth: true
    publicNetworkAccess: 'disabled'
    semanticSearch: 'free'
  }
  sku: {
    name: 'basic'
  }
}

resource storage_role_assignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storage_account.id, search_service.id, storage_blob_data_reader_role.id)
  scope: storage_account
  properties: {
    principalId: search_service.identity.principalId
    roleDefinitionId: storage_blob_data_reader_role.id
    principalType: 'ServicePrincipal'
  }
}

@description('Built-in Storage Blob Data Reader role (https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles/storage#storage-blob-data-reader).')
resource storage_blob_data_reader_role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
    name: '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
}

output name string = search_service.name
output endpoint string = 'https://${search_service.name}.search.windows.net'
