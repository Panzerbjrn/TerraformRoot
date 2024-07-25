terraform {
  required_providers {
    aws = { source  = "hashicorp/aws", version = "~> 3.0" }
    azurerm = { source  = "hashicorp/azurerm", version = "~> 3.0" }
    }
  }

provider "aws" { region = "eu-west-2" }

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. #
  ## If you're using version 1.x, the "features" block is not allowed. ##
  features {
    # api_management {
    #   purge_soft_delete_on_destroy = true
    #   recover_soft_deleted         = true
    # }

    # app_configuration {
    #   purge_soft_delete_on_destroy = true
    #   recover_soft_deleted         = true
    # }

    # application_insights {
    #   disable_generated_rule = false
    # }

    cognitive_account {
      purge_soft_delete_on_destroy = true
    }

    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

    # log_analytics_workspace {
    #   permanently_delete_on_destroy = true
    # }

    # machine_learning {
    #   purge_soft_deleted_workspace_on_destroy = true
    # }

    # managed_disk {
    #   expand_without_downtime = true
    # }

    # postgresql_flexible_server {
    #   restart_server_on_configuration_value_change = true
    # }

    # recovery_service {
    #   retain_data_and_stop_protection_on_back_vm_destroy = true
    #   purge_protected_items_from_vault_on_destroy        = true
    # }

    # resource_group {
    #   prevent_deletion_if_contains_resources = true
    # }

    # recovery_services_vault {
    #   recover_soft_deleted_backup_protected_vm = true
    # }

    # subscription {
    #   prevent_cancellation_on_destroy = false
    # }

    # template_deployment {
    #   delete_nested_items_during_deletion = true
    # }

    # virtual_machine {
    #   detach_implicit_data_disk_on_deletion = false
    #   delete_os_disk_on_deletion            = true
    #   graceful_shutdown                     = false
    #   skip_shutdown_and_force_delete        = false
    # }

    # virtual_machine_scale_set {
    #   force_delete                  = false
    #   roll_instances_when_required  = true
    #   scale_to_zero_before_deletion = true
    #}
  }
}