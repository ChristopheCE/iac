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

// Create sonar  resource group
resource "azurerm_resource_group" "sonar" {
  name     = "rg-sonar-${var.environment_code}"
  location = "westeurope"
}

// Creat App Service Plan
resource "azurerm_service_plan" "sonar" {
  name                = "plan-sonar-${var.environment_code}"
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
      docker_image     = "sonarqube"
      docker_image_tag = "9.6-community"
    }
  }
}