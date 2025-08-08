# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.39.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    access_key           = ""
    key                  = "" # this key has to be unique for this project
  }

  required_version = ">= 1.1.0"
}

locals {
  azure_creds = jsondecode(file("azure_credentials.json"))
}

provider "azurerm" {
  subscription_id = local.azure_creds.subscriptionId
  client_id       = local.azure_creds.clientId
  client_secret   = local.azure_creds.clientSecret
  tenant_id       = local.azure_creds.tenantId

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
