output "resource_group_1" { value = azurerm_resource_group.rg-1 }
output "resource_group_2" { value = azurerm_resource_group.ranged }

output "env_data" { value = var.env_data}

output "tags" { value = var.tags}

output "region_map" { value = var.region_map}

output "JoinedValue"  { value = local.JoinedValue }

output "Module_Global" { value = module.Global }

#output "Module_Resource_Group" { value = module.ResourceGroup }

output "Module_AI_Services_Account" {
    value = module.AI_Services_Account
    sensitive = true
}
output "Module_AI_Services_Account_Id" { value = module.AI_Services_Account.id }

output "current_client_id" { value = data.azurerm_client_config.current.client_id }
output "current_subscription_id" { value = data.azurerm_client_config.current.subscription_id }
output "current_tenant_id" { value = data.azurerm_client_config.current.tenant_id }
