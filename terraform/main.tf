provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "time" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on = [azurerm_resource_group.rg]
}

#module "vm" {
#  source                    = "./modules/vm"
#  resource_group_name       = var.resource_group_name
#  location                  = var.location
#  subnet_id                 = module.network.subnet_id
#  public_ip_address_id      = module.network.public_ip_id
#  network_security_group_id = module.network.nsg_id
#}

module "vm" {
  source                    = "./modules/vm"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  subnet_id                 = module.network.subnet_id
#  public_ip_address_id      = module.network.public_ip_id
  network_security_group_id = module.network.nsg_id
  public_ssh_key_path       = var.public_ssh_key_path

  public_ip_address_id_prometheus = module.network.public_ip_prometheus_id
  public_ip_address_id_rocketchat = module.network.public_ip_rocketchat_id

  prometheus_ip             = module.network.public_ip_prometheus
  rocketchat_ip             = module.network.public_ip_rocketchat
}


resource "time_sleep" "wait_for_azure" {
  depends_on     = [module.vm]
  create_duration = "10s"
}
