variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0fab1b527ffa9b942"
}
