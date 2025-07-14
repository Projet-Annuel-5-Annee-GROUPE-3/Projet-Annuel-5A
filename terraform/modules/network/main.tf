resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-monitoring"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-monitoring"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "22"
    source_address_prefix      = "90.0.63.116/32"
    destination_address_prefix = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "HTTP-Prometheus"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "9090"
    source_address_prefix      = "90.0.63.116/32"
    destination_address_prefix = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "HTTP-Grafana"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "3000"
    source_address_prefix      = "90.0.63.116/32"
    destination_address_prefix = "*"
    source_port_range          = "*"
  }

  # ✅ Autoriser la communication interne privée
  security_rule {
    name                       = "Allow-Internal-VNet"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}
# Groupe de sécurité Rocketchat
resource "azurerm_network_security_group" "nsg_rocketchat" {
  name                = "nsg-rocketchat"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "90.0.63.116/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Rocketchat-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "pip_prometheus" {
  name                = "pip-prometheus"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}
resource "azurerm_public_ip" "pip_rocketchat" {
  name                = "pip-rocketchat"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}
output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
