#output "public_ip_address" {
#  value = azurerm_public_ip.pip.ip_address
#}
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
