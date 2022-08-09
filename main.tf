terraform {
  cloud {
    organization = "Christophe"

    workspaces {
      name = "GitHub-Actions"
    }
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

// Create test messaging resource group
resource "azurerm_resource_group" "messaging" {
  name     = "rg-messaging-dev"
  location = "westeurope"
}