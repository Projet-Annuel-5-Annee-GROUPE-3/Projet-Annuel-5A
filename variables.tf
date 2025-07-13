variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "eks-GadgetSphere"
  type        = string
}

variable "vpc_id" {
  description = "vpc-0eb14028e5e516eb0"
  type        = string
}

variable "acm_certificate_arn" {
  description = "arn:aws:acm:eu-west-1:668516169738:certificate/99a9bb9e-2b5b-4131-a5fd-e3486047c47c"
  type        = string
}

variable "account_id" {
  description = "668516169738"
  type        = string
}
