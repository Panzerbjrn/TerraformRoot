terraform {
  required_providers {
    aws     = { source = "hashicorp/aws", version = "~> 3.0" }
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.0" }
  }
}

provider "aws" { region = "eu-west-2" }

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. #
  ## If you're using version 1.x, the "features" block is not allowed. ##
  features {
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }

    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  skip_provider_registration = true
}