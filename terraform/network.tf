# Red 

resource "azurerm_virtual_network" "myNet" {

	name			= "kubernetesnet"
	address_space		= ["10.0.0.0/16"]
	location		= azurerm_resource_group.rg.location
	resource_group_name	= azurerm_resource_group.rg.name

	tags = {
		environment = "CP2"
	}
}

# Subnet

resource "azurerm_subnet" "mySubnet" {
	name			= "terraformsubnet"
	resource_group_name	= azurerm_resource_group.rg.name
	virtual_network_name	= azurerm_virtual_network.myNet.name
	address_prefixes	= ["10.0.1.0/24"]
}


# Pausa 
resource "null_resource" "delay_after_subnet" {
  depends_on = [azurerm_subnet.mySubnet]

  provisioner "local-exec" {
    command = "sleep 30"
  }
}



# Nic

resource "azurerm_network_interface" "myNic1" {
	name			= "vmnic1"
	location		= azurerm_resource_group.rg.location
	resource_group_name	= azurerm_resource_group.rg.name

		ip_configuration {
		name				= "myipconfiguration1"
		subnet_id			= azurerm_subnet.mySubnet.id
		private_ip_address_allocation	= "Static"
		private_ip_address		= "10.0.1.10"
		public_ip_address_id		= azurerm_public_ip.myPublicIp1.id
		}
	

	depends_on = [null_resource.delay_after_subnet]

	tags = {
		environment = "CP2"
	}
}

# Ip pública

resource "azurerm_public_ip" "myPublicIp1" {
	name			= "vmip1"
	location		= azurerm_resource_group.rg.location
	resource_group_name	= azurerm_resource_group.rg.name
	allocation_method	= "Static"
	sku			= "Basic"

	tags = {
		environment = "CP2"
	}
} 

