
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
