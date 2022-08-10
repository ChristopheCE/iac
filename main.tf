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
  name     = "rg-test-dev"
  location = "westeurope"
}