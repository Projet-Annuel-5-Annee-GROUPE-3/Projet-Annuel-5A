#Deploiement instance Prometheus

resource "azurerm_network_interface" "nic" {
  name                = "nic-monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id_prometheus
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "Prometheus"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1s"
  admin_username        = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa_azure.pub")
  }

  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }
}

#output "public_ip" {
#  value = azurerm_network_interface.nic.ip_configuration[0].public_ip_address_id
#}
#output "prometheus_ip" {
#  value = azurerm_public_ip.pip.ip_address
#}
output "prometheus_ip" {
  value = var.prometheus_ip
}
#Deploiement instance Rocketchat

# Interface réseau Rocket.Chat
resource "azurerm_network_interface" "rocketchat_nic" {
  name                = "nic-rocketchat"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id_rocketchat
  }
}

# Association NSG → NIC
resource "azurerm_network_interface_security_group_association" "rocketchat_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.rocketchat_nic.id
  network_security_group_id = var.network_security_group_id
}

# Machine Rocket.Chat
resource "azurerm_linux_virtual_machine" "rocketchat" {
  name                  = "RocketChat"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.rocketchat_nic.id]
  size                  = "Standard_B1ms"
  admin_username        = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa_azure.pub")
  }

  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }
}

#output "rocketchat_ip" {
#  value = azurerm_public_ip.pip.ip_address
#}
output "rocketchat_ip" {
  value = var.rocketchat_ip
}
