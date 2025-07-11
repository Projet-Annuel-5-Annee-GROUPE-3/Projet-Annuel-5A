variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

#variable "public_ip_address_id" {
#  type = string
#}

variable "network_security_group_id" {
  type = string
}

variable "public_ssh_key_path" {
  description = "Chemin vers la clé publique SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "public_ip_address_id_prometheus" {
  type = string
}

variable "public_ip_address_id_rocketchat" {
  type = string
}

variable "prometheus_ip" {
  description = "Public IP Prometheus"
  type        = string
}

variable "rocketchat_ip" {
  description = "Public IP Rocket.Chat"
  type        = string
}
