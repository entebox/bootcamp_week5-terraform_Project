terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "<resource_group_name>"
        storage_account_name = "<storage_account_name>"
        container_name       = "<container_name>"
        key                  = "terraform.tfstate"
    }

}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}
