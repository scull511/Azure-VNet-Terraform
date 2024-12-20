# Virtual Network
resource "azurerm_virtual_network" "vnet_sc" {
  name                = "vnet_sc"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group_sc.location
  resource_group_name = azurerm_resource_group.resource_group_sc.name

  tags = {
    Name = "Virtual Network - SC"
  }
}