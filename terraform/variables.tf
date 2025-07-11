
variable "resource_group_name" {
  type    = string
  default = "rg-monitoring"
}

variable "location" {
  type    = string
  default = "francecentral"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}
variable "public_ssh_key_path" {
  description = "Path to your public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa_azure.pub"
}
