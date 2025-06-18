data "azurerm_client_config" "current" {}

#Create Resource Group Using Azure RM calls
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

#Create Single Resource Group Using Module
module "ResourceGroup_Single" {
  source = "./modules/az_resource_group"
  resource_group = {
    name     = "Demo_Module-${var.env_data.app.short_name}-RG"
    location = var.env_data.location
    tags     = var.tags
  }
}

#Create Resource Group Using Module and a range loop
module "ResourceGroup_Ranged" {
  source   = "./modules/az_resource_group"
  for_each = toset([for i in range(1, var.range + 1) : tostring(i)])

  resource_group = {
    name = join("-", [
      "Demo_Module",
      lower(var.env_data.company.short_name),
      lower(var.env_data.environment_name),
      lower(var.env_data.app.short_name),
      "ranged_rg-${each.key}"
    ])
    location = var.env_data.location
    tags     = var.tags
  }
}

module "ResourceGroup_ForEach" {
  source = "./modules/az_resource_group"
  for_each = { for k, rg in var.RG_Map : join("-", [
    lower(var.env_data.company.short_name),
    lower(var.env_data.environment_name),
    lower(var.env_data.app.short_name),
    rg.name
  ]) => rg }

  resource_group = {
    name = join("-", [
      "Demo_Module",
      lower(var.env_data.company.short_name),
      lower(var.env_data.environment_name),
      lower(var.env_data.app.short_name),
      "foreach",
      each.value.name
    ])
    location = each.value.location
    tags     = each.value.tags
  }
}
