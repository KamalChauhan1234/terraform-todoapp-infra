terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
   backend "azurerm" {
    subscription_id = "01ea0417-d11f-43fb-abdd-b2f167d94a39"
    resource_group_name  = "rg-devopsinsiders"
    storage_account_name = "twostates1 "
    container_name       = "tfstate"
    key                  = "dev.tfstate"
    
  } 
}

provider "azurerm" {
  features {}
  subscription_id = "01ea0417-d11f-43fb-abdd-b2f167d94a39"
}

