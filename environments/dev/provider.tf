terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-stg"
    storage_account_name = "stgmicro"
    container_name       = "containermicro"
    key                  = "dev.tfstatee"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "caba13fb-1019-44a6-817f-cc5eb0ec1c55"
}
