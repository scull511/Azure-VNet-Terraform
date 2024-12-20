# Route Table (Public)
resource "azurerm_route_table" "public_route_table_sc" {
  name                = "public-route-table"
  location            = azurerm_resource_group.resource_group_sc.location
  resource_group_name = azurerm_resource_group.resource_group_sc.name
  tags = {
    Name = "Public Route Table for SC"
  }

  route {
    name           = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

# Route Table (Private)
resource "azurerm_route_table" "private_route_table_sc" {
  name                = "private-route-table"
  location            = azurerm_resource_group.resource_group_sc.location
  resource_group_name = azurerm_resource_group.resource_group_sc.name
}