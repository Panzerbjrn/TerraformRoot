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
module "AI_Services_Account" {
  source          = "./modules/az_ai_services_account"
  env_data       = local.env_data
  function       = "ais_account"
  resource_group = azurerm_resource_group.rg-1
  kind           = "CognitiveServices"
  sku_name       = "S0"
}

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
  source = "./modules/az_webapp_windows"
  env_data = local.env_data
  resource_group = local.resource_group
  tags           = local.tags
}

##### Testing WebApp Linux: 
# module "webapp_linux" {
#   source = "../../modules/webapp_linux"
#   env_data = local.env_data
#   resource_group = local.resource_group
#   tags           = local.tags
# }
