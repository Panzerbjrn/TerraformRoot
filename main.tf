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

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-${random_id.suffix.hex}" # Must be globally unique
}

resource "random_id" "suffix" {
  byte_length = 4
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

data "aws_region" "current" {}
output "aws_region" {
  value = data.aws_region.current.name
}

data "aws_caller_identity" "current" {}
output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}