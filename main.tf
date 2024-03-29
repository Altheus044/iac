terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }

  # Update this block with the location of your terraform state file
  backend "azurerm" {
    resource_group_name  = "rg-iac"
    storage_account_name = "stghiacstates2024"
    container_name       = "tfstatefile"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
data "azurerm_client_config" "current" {}

# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "rg_adls" {
  count    = var.adls_deploy_flag ? 1 : 0
  name     = var.adls_resource_group_name
  location = var.location
  tags     = local.tags
}
resource "azurerm_storage_account" "st_adls" {
  count                    = var.adls_deploy_flag ? 1 : 0
  name                     = var.st_adls_name
  resource_group_name      = azurerm_resource_group.rg_adls[0].name
  location                 = azurerm_resource_group.rg_adls[0].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adls" {
  count              = var.adls_deploy_flag ? 1 : 0
  name               = var.adls_name
  storage_account_id = azurerm_storage_account.st_adls[0].id

  properties = {
    hello = "aGVsbG8="
  }
}

# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "rg_adf" {
  count    = var.adf_deploy_flag ? 1 : 0
  name     = var.adf_resource_group_name
  location = var.location
}

/*resource "azurerm_key_vault" "adf_key_vault" {
  count                    = var.avk_deploy_flag ? 1 : 0
  name                     = var.kv_adf_name
  location                 = azurerm_resource_group.rg_adf[0].location
  resource_group_name      = azurerm_resource_group.rg_adf[0].name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  soft_delete_enabled      = true
  purge_protection_enabled = false
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.az_service_principal_object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
      "set",
      "delete",
      "list",
    ]

    storage_permissions = [
      "get",
    ]
  }
}

resource "azurerm_key_vault_secret" "adf_vk_secret" {
  name         = "AdfKvSecret"
  value        = var.kv_value
  key_vault_id = azurerm_key_vault.adf_key_vault.id
}*/

resource "azurerm_data_factory" "adf" {
  count               = var.adf_deploy_flag ? 1 : 0
  name                = var.adf_name
  location            = azurerm_resource_group.rg_adf[0].location
  resource_group_name = azurerm_resource_group.rg_adf[0].name
}
/*resource "azurerm_data_factory_linked_service_key_vault" "linked_adf_key_vault" {
  count           = var.adf_deploy_flag ? 1 : 0
  name            = "linked-adf_key_vault"
  data_factory_id = azurerm_data_factory.adf[0].id
  key_vault_id    = azurerm_key_vault.adf_key_vault[0].id
}*/

/*# Retrieve the storage account details, including the private endpoint connections
data "azapi_resource" "example_storage" {
  type                   = "Microsoft.Storage/storageAccounts@2022-09-01"
  resource_id            = azurerm_storage_account.st_adls.id
  response_export_values = ["properties.privateEndpointConnections"]
}

# Retrieve the private endpoint connection name from the storage account based on the private endpoint name
locals {
  private_endpoint_connection_name = element([
  for connection in jsondecode(data.azapi_resource.example_storage.output).properties.privateEndpointConnections
  : connection.name
  if endswith(connection.properties.privateEndpoint.id, azurerm_synapse_managed_private_endpoint.example.name)
  ], 0)
}

# Approve the private endpoint
resource "azapi_update_resource" "approval" {
  type      = "Microsoft.Storage/storageAccounts/privateEndpointConnections@2022-09-01"
  name      = local.private_endpoint_connection_name
  parent_id = azurerm_storage_account.st_adls.id

  body = jsonencode({
    properties = {
      privateLinkServiceConnectionState = {
        description = "Approved via Terraform"
        status      = "Approved"
      }
    }
  })
}*/

/*resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "linked_adls" {
  name                = "linked_adls"
  data_factory_id     = azurerm_data_factory.adf.id
  account_name        = "example"
  tenant_id           = var.TF_VAR_AZURE_TENANT
  service_principal_id = data.azurerm_client_config.current.client_id
  url = ""
}*/

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "example" {
  count                = var.adf_deploy_flag ? 1 : 0
  name                 = "linked_adf_adls"
  data_factory_id      = azurerm_data_factory.adf[0].id
  url                  = "https://${var.adls_name}dfs.core.windows.net"
  use_managed_identity = true
}
