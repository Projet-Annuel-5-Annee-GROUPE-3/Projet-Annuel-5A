variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0ae3b6e2bb8033932", "subnet-0b63401edfbc7267f", "subnet-052c17d2323a2f8e1"]
}

resource "aws_ec2_tag" "role_elb" {
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "cluster" {
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "owned"
}
