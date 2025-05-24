locals {
  tags     = var.tags
  env_data = var.env_data

  location_map = {
    eastus      = { name = "eastus", short_name = "ue1", long_name = "EastUS" }
    northeurope = { name = "northeurope", short_name = "en1", long_name = "NorthEurope" }
    uksouth     = { name = "uksouth", short_name = "uks", long_name = "UKSouth" }
    westeurope  = { name = "westeurope", short_name = "ew1", long_name = "WestEurope" }
  }

  environment_map = {
    dev  = { name = "dev", short_name = "d", long_name = "Development" }
    demo = { name = "demo", short_name = "o", long_name = "Demo" }
    test = { name = "test", short_name = "t", long_name = "Test" }
    qa   = { name = "qa", short_name = "q", long_name = "QA" }
    uat  = { name = "uat", short_name = "u", long_name = "UAT" }
    prod = { name = "prod", short_name = "p", long_name = "Production" }
    dos  = { name = "dos", short_name = "s", long_name = "DevOpsServices" }
  }

  JoinedValue = join("-", [
    lower(var.env_data.company.short_name),
    lower(var.env_data.environment_name),
    "jv"
  ])
}