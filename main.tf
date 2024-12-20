# Configure Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "rg_sc" {
  name     = "sc-resource-group"
  location = "West Europe" # Update with your desired location
  tags = {
    Name = "Resource Group for SC"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet_sc" {
  name                = "vnet-sc"
  address_space       = "10.0.0.0/16"
  location            = azurerm_resource_group.rg_sc.location
  resource_group_name = azurerm_resource_group.rg_sc.name
  tags = {
    Name = "Virtual Network for SC"
  }
}

# Public Subnet
resource "azurerm_subnet" "public_subnet_sc" {
  name                     = "public-subnet"
  address_prefixes         = ["10.0.1.0/24"]
  resource_group_name       = azurerm_resource_group.rg_sc.name
  virtual_network_name     = azurerm_virtual_network.vnet_sc.name
  delegations              = ["Microsoft.Network/publicIPAddresses"] # Allow Public IP assignment
  enforce_private_link_end = false # Allow internet access
  tags = {
    Name = "Public Subnet for SC"
  }
}

# Private Subnet
resource "azurerm_subnet" "private_subnet_sc" {
  name                     = "private-subnet"
  address_prefixes         = ["10.0.2.0/24"]
  resource_group_name       = azurerm_resource_group.rg_sc.name
  virtual_network_name     = azurerm_virtual_network.vnet_sc.name
  enforce_private_link_end = true # Block internet access
  tags = {
    Name = "Private Subnet for SC"
  }
}

# Public IP Address
resource "azurerm_public_ip_address" "nat_ip_sc" {
  name                = "nat-ip"
  location            = azurerm_resource_group.rg_sc.location
  resource_group_name = azurerm_resource_group.rg_sc.name
  allocation_method   = "Dynamic" # Dynamically allocate IP
  sku {
    name = "Basic"
  }
  tags = {
    Name = "Public IP for NAT Gateway"
  }
}

# NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway_sc" {
  name                = "nat-gateway"
  location            = azurerm_resource_group.rg_sc.location
  resource_group_name = azurerm_resource_group.rg_sc.name
  public_ip_address_id = azurerm_public_ip_address.nat_ip_sc.id
  subnet_id           = azurerm_subnet.public_subnet_sc.id
  tags = {
    Name = "NAT Gateway for SC"
  }
}

# Route Table (Public)
resource "azurerm_route_table" "public_route_table_sc" {
  name                = "public-route-table"
  location            = azurerm_resource_group.rg_sc.location
  resource_group_name = azurerm_resource_group.rg_sc.name
  tags = {
    Name = "Public Route Table for SC"
  }

  route {
    name          = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

# Route Table (Private)
resource "azurerm_route_table" "private_route_table_sc" {
  name                = "private-route-table"
  location            = azurerm_resource_group.rg_sc.name
  resource_group_name = azurerm_resource_group.rg_sc.