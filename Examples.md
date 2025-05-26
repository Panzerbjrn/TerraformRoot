resource "azurerm_resource_group" "rg-1" {
  name = join("-", [
    lower(var.env_data.company.short_name),
    lower(var.env_data.environment_name),
    lower(var.env_data.app.short_name),
    "rg1"
  ])
  location = var.env_data.location
  tags     = var.tags
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
  tags     = var.tags
}


module "ResourceGroup" {
  source = "./modules/az_resource_group"

  resource_group = {
    name     = "Demo_Module-${var.env_data.app.short_name}-RG"
    location = var.env_data.location
    tags     = var.tags
  }
}
