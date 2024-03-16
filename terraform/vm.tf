# Máquina virtual

resource "azurerm_linux_virtual_machine" "myVM1" {
	name			= "VMazureCP2"
	resource_group_name	= azurerm_resource_group.rg.name
	location		= azurerm_resource_group.rg.location
	size			= var.vm_size
	admin_username		= "cp2user"
	network_interface_ids	= [ azurerm_network_interface.myNic1.id ]
	disable_password_authentication	= true

	admin_ssh_key {
		username	= "cp2user"
		public_key = file("~/.ssh/id_rsa.pub")
	}

	os_disk {
		caching			= "ReadWrite"
		storage_account_type	= "Standard_LRS"
	}

	plan {
		name		= "centos-8-stream-free"
		product		= "centos-8-stream-free"
		publisher	= "cognosys"
	}

	source_image_reference {
		publisher	= "cognosys"
		offer		= "centos-8-stream-free"
		sku		= "centos-8-stream-free"
		version		= "22.03.28"
	}
	
	boot_diagnostics {
		storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
	}
	
	tags = {
		environment = "CP2"
	}
}		

resource "null_resource" "add_ssh_key" {
  depends_on = [
    azurerm_linux_virtual_machine.myVM1,
  ]

  provisioner "local-exec" {
    command = "ssh-keyscan -H ${azurerm_public_ip.myPublicIp1.ip_address} >> ~/.ssh/known_hosts"
  }
}
