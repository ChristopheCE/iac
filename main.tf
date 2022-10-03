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

// Create vulnerable resource group
resource "azurerm_resource_group" "vulnerable" {
  name     = "rg-vulnerable-${var.environment_code}"
  location = "westeurope"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vulnerable" {
  name                = "kv-vulnerable-${var.environment_code}"
  location            = azurerm_resource_group.vulnerable.location
  resource_group_name = azurerm_resource_group.vulnerable.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}