output "public_ip_prometheus_id" {
  value = azurerm_public_ip.pip_prometheus.id
}

output "public_ip_rocketchat_id" {
  value = azurerm_public_ip.pip_rocketchat.id
}

output "public_ip_prometheus" {
  value = azurerm_public_ip.pip_prometheus.ip_address
}

output "public_ip_rocketchat" {
  value = azurerm_public_ip.pip_rocketchat.ip_address
}
output "rocketchat_nsg_id" {
  value = azurerm_network_security_group.nsg_rocketchat.id
}
