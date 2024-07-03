output "resource_group_1" { value = azurerm_resource_group.rg-1 }
output "resource_group_2" { value = azurerm_resource_group.ranged }

output "env_data" { value = var.env_data}

output "tags" { value = var.tags}

output "region_map" { value = var.region_map}

output "JoinedValue"  { value = local.JoinedValue }

output "Module_Global" { value = module.global }

