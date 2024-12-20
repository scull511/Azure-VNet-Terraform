# Public Subnet
resource "azurerm_subnet" "public_subnet_sc" {
  name                 = "public_subnet_sc"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = azurerm_resource_group.resource_group_sc.name
  virtual_network_name = azurerm_virtual_network.vnet_sc.name
}

# # Private Subnet
resource "azurerm_subnet" "private_subnet_sc" {
  name                 = "private_subnet_sc"
  address_prefixes     = ["10.0.2.0/24"]
  resource_group_name  = azurerm_resource_group.resource_group_sc.name
  virtual_network_name = azurerm_virtual_network.vnet_sc.name
}