terraform {
  backend "azurerm" {
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.8.0"
    }
  }
}

provider "azurerm" {
  features {}
}

// Create test  resource group
resource "azurerm_resource_group" "test" {
  name     = "rg-actions-${var.environment_code}"
  location = "westeurope"
}

// Create storage account
resource "azurerm_storage_account" "test" {
  name                            = "sttest${var.environment_code}"
  resource_group_name             = azurerm_resource_group.test.name
  location                        = azurerm_resource_group.test.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
}