@description('Name of OpenAI Service resource.')
param name string = 'oai-${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of GPT model deployment.')
param gpt_deployment_name string = 'gpt-4o-mini'
@description('Capacity of GPT model deployment.')
param gpt_deployment_capacity int = 20
@description('Name of GPT model to deploy.')
param gpt_model string = 'gpt-4o-mini'
@description('Model version of GPT model to deploy.')
param gpt_model_version string = '2024-07-18'

@description('Name of embedding model deployment.')
param embedding_deployment_name string = 'text-embedding-ada-002'
@description('Capacity of embedding model deployment.')
param embedding_deployment_capacity int = 20
@description('Name of embedding model to deploy.')
param embedding_model string = 'text-embedding-ada-002'
@description('Model version of embedding model to deploy.')
param embedding_model_version string = '2'
@description('Model dimensions of embedding model to deploy.')
param embedding_model_dimensions int = 1536

resource openai_service 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: name
  location: location
  kind: 'OpenAI'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    disableLocalAuth: true
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
    }
  }
  sku: {
    name: 'S0'
  }
}

resource gpt_deployment 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  name: gpt_deployment_name
  parent: openai_service
  properties: {
    model: {
      format: 'OpenAI'
      name: gpt_model
      version: gpt_model_version
    }
  }
  sku: {
    name: 'Standard'
    capacity: gpt_deployment_capacity
  }
}

resource embedding_deployment 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  name: embedding_deployment_name
  parent: openai_service
  properties: {
    model: {
      format: 'OpenAI'
      name: embedding_model
      version: embedding_model_version
    }
  }
  sku: {
    name: 'Standard'
    capacity: embedding_deployment_capacity
  }
}

output name string = openai_service.name
output endpoint string = openai_service.properties.endpoint
output gpt_deployment_name string = gpt_deployment.name
output embedding_deployment_name string = embedding_deployment.name
output embedding_model_name string = embedding_deployment.properties.model.name
output embedding_model_dimensions int = embedding_model_dimensions
