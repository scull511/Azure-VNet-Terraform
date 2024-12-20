# Public IP Address
resource "azurerm_public_ip" "nat_ip_sc" {
  name                = "nat_ip_sc"
  location            = azurerm_resource_group.resource_group_sc.location
  resource_group_name = azurerm_resource_group.resource_group_sc.name
  allocation_method   = "Static"

  tags = {
    Name = "Public IP for NAT Gateway"
  }
}

# NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway_sc" {
  name                = "nat_gateway_sc"
  location            = azurerm_resource_group.resource_group_sc.location
  resource_group_name = azurerm_resource_group.resource_group_sc.name
}