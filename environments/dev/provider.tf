terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-p4"
    storage_account_name = "stgp4"
    container_name       = "kkp4"
    key                  = "dev.tfstatee"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7d7e4c65-1bfb-4455-b143-d0d76737869b"
}
