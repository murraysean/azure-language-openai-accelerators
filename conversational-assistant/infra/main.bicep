// ========== main.bicep ========== //
targetScope = 'resourceGroup'

// TODO: random vars
var base_url = 'TODO'
var clone_url = 'TODO'

// Deploy resources:
module container_registry 'resources/container_registry.bicep' = {
  name: 'deploy_container_registry'
}

module storage_account 'resources/storage_account.bicep' = {
  name: 'deploy_storage_account'
}

module openai_service 'resources/openai_service.bicep' = {
  name: 'deploy_openai_service'
}

module search_service 'resources/search_service.bicep' = {
  name: 'deploy_search_service'
  params: {
    storage_account_name: storage_account.outputs.name
  }
}

module language_service 'resources/language_service.bicep' = {
  name: 'deploy_language_service'
  params: {
    search_service_name: search_service.outputs.name
  }
}

module managed_identity 'resources/managed_identity.bicep' = {
  name: 'deploy_managed_identity'
  params: {
    container_registry_name: container_registry.outputs.name
    language_service_name: language_service.outputs.name
    openai_service_name: openai_service.outputs.name
    search_service_name: search_service.outputs.name
    storage_account_name: storage_account.outputs.name
  }
}

// Deploy scripts:
module language_setup 'scripts/language_setup_script.bicep' = {
  name: 'run_language_setup'
  params: {
    base_url: base_url
    language_endpoint: language_service.outputs.endpoint
    managed_identity_object_id: managed_identity.outputs.id
  }
}

module search_setup 'scripts/search_setup_script.bicep' = {
  name: 'run_search_setup'
  params: {
    aoai_endpoint: openai_service.outputs.endpoint
    base_url: base_url
    blob_container_name: storage_account.outputs.blob_container_name
    embedding_deployment_name: openai_service.outputs.embedding_deployment_name
    embedding_model_dimensions: openai_service.outputs.embedding_model_dimensions
    embedding_model_name: openai_service.outputs.embedding_model_name
    managed_identity_object_id: managed_identity.outputs.id
    search_endpoint: search_service.outputs.endpoint
    storage_account_connection_string: storage_account.outputs.storage_account_connection_string
    storage_account_name: storage_account.outputs.name
  }
}

module registry_setup 'scripts/registry_setup_script.bicep' = {
  name: 'run_registry_setup'
  params: {
    acr_name: container_registry.outputs.name
    base_url: base_url
    clone_url: clone_url
    managed_identity_object_id: managed_identity.outputs.id
  }
}

// TODO: deploy Container Apps...
