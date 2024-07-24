data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "rg-1" {
    name = join("-", [
    lower(var.env_data.company.short_name),
    lower(var.env_data.environment_name),
    lower(var.env_data.app.short_name),
    "rg1"
  ])
  location = var.env_data.location
  tags = var.tags
}

#Create Resource Group
resource "azurerm_resource_group" "ranged" {
  for_each = toset([for i in range(1, var.range + 1) : tostring(i)])
  name = join("-", [
    lower(var.env_data.company.short_name),
    lower(var.env_data.environment_name),
    lower(var.env_data.app.short_name),
    "foreach_rg-${each.key}"
  ])
  location = var.env_data.location
  tags = var.tags
}

# Grant KV admin at RG
resource "azurerm_role_assignment" "admin_role" {
  scope                = azurerm_resource_group.rg-1.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.sp_oid
#  principal_id         = "8c7fdad8-7c77-4b54-9261-202c989038f1"
}

module "Global" {
  source             = "./modules/_global"
  environment_name   = local.env_data.environment_name
  location           = local.env_data.location_name
  company_short_name = local.env_data.company.short_name
  app_long_name      = local.env_data.app.long_name
  app_short_name     = local.env_data.app.short_name
}

module "ResourceGroup" {
  source = "./modules/az_resource_group"
  
  resource_group = {
    name     = "Demo_Module-${var.env_data.app.short_name}-RG"
    location = var.env_data.location
    tags = var.tags
  }
}

##### Testing 
##### Testing AI Service: 
# module "AI_Services_Account" {
#   source                    = "./modules/az_ai_services_account"
#   env_data                  = local.env_data
#   function                  = "aisa"
#   resource_group            = azurerm_resource_group.rg-1
#   kind                      = "CognitiveServices"
#   sku_name                  = "S0"
#   purge_protection_enabled = false
# }

resource "azurerm_cognitive_account" "main" {
  name = join("-", [
    lower(var.env_data.company.short_name),
    lower(var.env_data.environment_name),
    lower(var.env_data.app.short_name),
    "aca"
  ])

  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
  kind                = "CognitiveServices"
  sku_name            = "S0"
}

##### Testing 
##### Testing WebApp Windows:
module "webapp_windows" {
  source         = "./modules/az_webapp_windows"
  env_data       = local.env_data
  resource_group = azurerm_resource_group.rg-1
  sku_name       = "P1v2"
  tags           = local.tags
}

##### Testing WebApp Linux: 
module "webapp_linux" {
  source = "./modules/az_webapp_linux"
  env_data = local.env_data
  resource_group = azurerm_resource_group.rg-1
  sku_name       = "P1v2"
  tags           = local.tags
}


# data "azurerm_client_config" "current" {}
# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West US"
# }

# resource "azurerm_user_assigned_identity" "example" {
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   name                = "example-identity"
# }

# resource "azurerm_cognitive_account" "example" {
#   name                  = "example-account"
#   location              = azurerm_resource_group.example.location
#   resource_group_name   = azurerm_resource_group.example.name
#   kind                  = "Face"
#   sku_name              = "E0"
#   custom_subdomain_name = "example-account"
#   identity {
#     type         = "SystemAssigned, UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.example.id]
#   }
# }

# resource "azurerm_key_vault" "example" {
#   name                     = "example-vault"
#   location                 = azurerm_resource_group.example.location
#   resource_group_name      = azurerm_resource_group.example.name
#   tenant_id                = data.azurerm_client_config.current.tenant_id
#   sku_name                 = "standard"
#   purge_protection_enabled = true

#   access_policy {
#     tenant_id = azurerm_cognitive_account.example.identity[0].tenant_id
#     object_id = azurerm_cognitive_account.example.identity[0].principal_id
#     key_permissions = [
#       "Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"
#     ]
#     secret_permissions = [
#       "Get",
#     ]
#   }

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id
#     key_permissions = [
#       "Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"
#     ]
#     secret_permissions = [
#       "Get",
#     ]
#   }

#   access_policy {
#     tenant_id = azurerm_user_assigned_identity.example.tenant_id
#     object_id = azurerm_user_assigned_identity.example.principal_id
#     key_permissions = [
#       "Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"
#     ]
#     secret_permissions = [
#       "Get",
#     ]
#   }
# }

# resource "azurerm_key_vault_key" "example" {
#   name         = "example-key"
#   key_vault_id = azurerm_key_vault.example.id
#   key_type     = "RSA"
#   key_size     = 2048
#   key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
# }

# resource "azurerm_cognitive_account_customer_managed_key" "example" {
#   cognitive_account_id = azurerm_cognitive_account.example.id
#   key_vault_key_id     = azurerm_key_vault_key.example.id
#   identity_client_id   = azurerm_user_assigned_identity.example.client_id
# }