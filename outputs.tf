output "JoinedValue"  { value = local.JoinedValue }

# output "Module_AI_Services_Account" {
#     value = module.AI_Services_Account
#     sensitive = true
# }
# output "Module_AI_Services_Account_Id" { value = module.AI_Services_Account.id }

output "Module_Global" { value = module.Global }


output "data_current_client_id" { value = data.azurerm_client_config.current.client_id }
output "data_current_subscription_id" { value = data.azurerm_client_config.current.subscription_id }
output "data_current_tenant_id" { value = data.azurerm_client_config.current.tenant_id }



output "resource_group_1" { value = azurerm_resource_group.rg-1 }
output "resource_group_ranged" { value = azurerm_resource_group.ranged }


output "var_env_data" { value = var.env_data}
output "var_region_map" { value = var.region_map}
output "var_tags" { value = var.tags}

#output "var_sp_oid" { value = var.sp_oid}
#output "Module_Resource_Group" { value = module.ResourceGroup }
