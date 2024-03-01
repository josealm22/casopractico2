terraform {
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "=3.0"
		}
	}
}
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
	name		= "kubernetes_rg"
	location	= var.location

	tags = {
		environment = "CP2"
	}
}

resource "azurerm_storage_account" "stAccount" {
	name				= "staccountcp2dv"	
	resource_group_name		= azurerm_resource_group.rg.name
	location			= azurerm_resource_group.rg.location
	account_tier			= "Standard"
	account_replication_type	= "LRS"

	tags = {
		environment = "CP2"
	}
}
