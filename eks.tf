resource "aws_eks_cluster" "eks" {
  name     = "eks-GadgetSphere"
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKSAutoClusterRole"

  vpc_config {
    subnet_ids = [
      "subnet-0ae3b6e2bb8033932",
      "subnet-0b63401edfbc7267f",
      "subnet-052c17d2323a2f8e1"

    ]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  tags = {
    Name = "eks-GadgetSphere"
  }

  depends_on = [data.aws_iam_role.eks_cluster_role]
}

# IAM Identity info
data "aws_caller_identity" "current" {}

# IAM Role (assume qu'il existe déjà)
data "aws_iam_role" "eks_cluster_role" {
  name = "AmazonEKSAutoClusterRole"
}


