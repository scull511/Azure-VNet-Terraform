# Security Groups
resource "azurerm_network_security_group" "vnet_sc_nsg" {
  name                = "vnet_sc_sg"
  location            = azurerm_resource_group.resource_group_sc.location
  resource_group_name = azurerm_resource_group.resource_group_sc.name

  # Public Subnet Rules:
  security_rule {
    name                       = "Public_Subnet_Inbound_Allow_All"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range       = "*"
    source_address_prefix       = "0.0.0.0/0"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "Public_Subnet_Outbound_Allow_All"
    priority                    = 200
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range       = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "0.0.0.0/0"
  }

  # Private Subnet Rules:
  security_rule {
    name                       = "Private_Subnet_Inbound_Deny_All"
    priority                    = 300
    direction                   = "Inbound"
    access                      = "Deny"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range       = "*"
    source_address_prefix       = "0.0.0.0/0"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "Private_Subnet_Outbound_Allow_All"
    priority                    = 400
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range       = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "0.0.0.0/0"
  }
}