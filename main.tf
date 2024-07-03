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

/* 
module "global" {
  source             = "./modules/_global"
  environment_name   = local.env_data.environment_name
  location           = local.env_data.location_name
  company_short_name = local.env_data.company.short_name
  app_long_name      = local.env_data.app.long_name
  app_short_name     = local.env_data.app.short_name
}

module "ResourceGroup" {
  source = "./modules/resource_group"
  
  resource_group = {
    name     = "Demo_Module-${var.env_data.app.short_name}-RG"
    location = var.env_data.location
    tags = var.tags
  }
}
*/