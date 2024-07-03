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
    "module-rg-${each.key}"
  ])
  location = var.env_data.location
  tags = var.tags
}

module "global" {
  source             = "./modules/_global"
  environment_name   = local.env_data.environment_name
  location           = local.env_data.location_name
  company_short_name = local.env_data.company.short_name
  app_long_name      = local.env_data.app.long_name
  app_short_name     = local.env_data.app.short_name
}

/*
module "ResourceGroup" {
  source = "./modules/resource_group"
  
  resource_group = {
    name     = "Demo_Module-${var.env_data.app.short_name}-RG"
    location = var.env_data.location
    tags = var.tags
  }
}
*/

##### Testing 
##### Testing AI Service: 
# module "ai_services" {
#   source         = "../../modules/ai_services"
#   env_data       = local.env_data
#   function       = "ai_test"
#   resource_group = local.env_data.resource_group
# #  subnet         = module.ref_net.subnets.internal
# }

# resource "azurerm_cognitive_account" "main" {
#       name = join("-", [
#     lower(var.env_data.company.short_name),
#     lower(var.env_data.environment_name),
#     lower(var.env_data.app.short_name),
#     "aca"
#   ])

#   location            = data.azurerm_resource_group.main.location
# #  resource_group_name = azurerm_resource_group.rg-1.name
#   resource_group  = data.azurerm_resource_group.main
#   kind                = "OpenAI"
#   sku_name            = "S0"
# }

# resource "azurerm_cognitive_deployment" "main" {
#   name = join("-", [
#     lower(var.env_data.company.short_name),
#     lower(var.env_data.environment_name),
#     lower(var.env_data.app.short_name),
#     "acd"
#   ])

#   cognitive_account_id = azurerm_cognitive_account.main.id
#   model {
#     format  = "OpenAI"
#     name    = "text-curie-001"
#     version = "1"
#   }

#   scale {
#     type = "Standard"
#   }
# }
