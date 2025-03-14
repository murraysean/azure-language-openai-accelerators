@description('Name of Storage Account resource.')
param name string = 'st_${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Blob container name.')
param blob_container_name string = 'contoso-outdoors-manuals'

resource storage_account 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  properties: {
    allowSharedKeyAccess: false
  }
  sku: {
    name: 'Standard_LRS'
  }
}

resource blob_service 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storage_account
}

resource blob_container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: blob_container_name
  parent: blob_service
  properties: {
    publicAccess: 'None'
  }
}

output name string = storage_account.name
output blob_container_name string = blob_container.name
output storage_account_connection_string string = 'ResourceId=${storage_account.id}'
