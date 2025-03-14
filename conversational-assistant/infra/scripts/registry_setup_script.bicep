@description('Location for all resources.')
param location string = resourceGroup().location

param image_tag string = utcNow()
param acr_name string
param frontend_image string = '${acr_name}.azurecr.io/conv-assistant/frontend-app:${image_tag}'
param backend_image string = '${acr_name}.azurecr.io/conv-assistant/backend-server:${image_tag}'
param clone_url string

@description('Object ID of managed identity to use for deployment script.')
param managed_identity_object_id string

@description('Base url of Conversational-Assistant project in GitHub repo.')
param base_url string

resource registry_setup_script 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'registry_setup_script'
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managed_identity_object_id}' : {}
    }
  }
  properties: {
    azCliVersion: '2.50.0'
    primaryScriptUri: '${base_url}infra/scripts/registry/run_registry_setup.sh'
    arguments: 'false ${acr_name} ${backend_image} ${frontend_image} ${clone_url}'
    timeout: 'PT1H'
    retentionInterval: 'PT1H'
    cleanupPreference: 'OnSuccess'
  }
}

output frontend_image string = frontend_image
output backend_image string = backend_image
