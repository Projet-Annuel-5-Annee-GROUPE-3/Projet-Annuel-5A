output "prometheus_ip" {
  value = module.network.public_ip_prometheus
}

output "rocketchat_ip" {
  value = module.network.public_ip_rocketchat
}
