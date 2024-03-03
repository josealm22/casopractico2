terraform {
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "=3.94.0"
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

resource "azurerm_container_registry" "acrCp2" {
	name				= "acrcp2dv"
	resource_group_name		= azurerm_resource_group.rg.name
	location			= azurerm_resource_group.rg.location
	sku				= "Premium"
}

resource "azurerm_kubernetes_cluster" "aksCp2" {
	name				= "aks-cp2dv"
	location			= azurerm_resource_group.rg.location
	resource_group_name		= azurerm_resource_group.rg.name
	dns_prefix			= "akscp2dc"

	default_node_pool {
		name		= "default"
		node_count	= 1
		vm_size		= "Standard_D2_v2"
	}
	
	

	service_principal {
		client_id	= var.client_id
		client_secret	= var.client_secret
	}
	
	
	tags = {
		Environment = "CP2"
	}
}



output "client_certificate" {
	value		= azurerm_kubernetes_cluster.aksCp2.kube_config[0].client_certificate
	sensitive	= true
}

output "kube_config" {
	value		= azurerm_kubernetes_cluster.aksCp2.kube_config_raw
	sensitive	= true
} 
