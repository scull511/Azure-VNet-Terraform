# Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

data "azurerm_subscription" "subscription" {
  subscription_id = "###"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group_sc" {
  name     = "resource_group_sc"
  location = "UK South"
}