# Grupo de seguridad

resource "azurerm_network_security_group" "cp2SecGroup" {
    name                = "traficosshhttp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    # Regla para SSH
    security_rule {
        name                        = "SSH"
        priority                    = 1001
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "22"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }

    # Regla para HTTP
    security_rule {
        name                        = "HTTP"
        priority                    = 1002
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "80"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }
    
    # Regla para HTTP
    security_rule {
        name                        = "HTTPS"
        priority                    = 1003
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Asociación del Grupo de Seguridad a la Interfaz de Red
resource "azurerm_network_interface_security_group_association" "cp2SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.myNic1.id
    network_security_group_id = azurerm_network_security_group.cp2SecGroup.id
}
