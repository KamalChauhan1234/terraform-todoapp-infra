terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rgweb"
    storage_account_name = "stgweb"
    container_name       = "kkcon"
    key                  = "dev.tfstatee"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7d7e4c65-1bfb-4455-b143-d0d76737869b"
}

