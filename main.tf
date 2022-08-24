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
  name                     = "sttest${var.environment_code}"
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

// Create storage container
resource "azurerm_storage_container" "test" {
  name                 = "data"
  storage_account_name = azurerm_storage_account.test.name
}

// Create container registry
resource "azurerm_container_registry" "test" {
  name                = "cr-actions-${var.environment_code}"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  sku                 = "Standard"
}

// Create sonar  resource group
resource "azurerm_resource_group" "sonar" {
  name     = "rg-sonar-${var.environment_code}"
  location = "westeurope"
}

// Creat App Service Plan
resource "azurerm_service_plan" "sonar" {
  name = "plan-sonar-${var.environment_code}"
  resource_group_name = azurerm_resource_group.sonar.name
  location            = azurerm_resource_group.sonar.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "sonar" {
  name                = "app-sonar-${var.environment_code}"
  resource_group_name = azurerm_resource_group.sonar.name
  location            = azurerm_service_plan.sonar.location
  service_plan_id     = azurerm_service_plan.sonar.id

  site_config {
    application_stack {
      docker_image = "sonarqube"
      tdocker_image_tag = "9.6-community"    
    }
  }
}