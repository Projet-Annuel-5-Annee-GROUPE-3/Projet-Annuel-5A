resource "aws_eks_node_group" "gadget_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "GadgetSphere-node-groups"
  node_role_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/node-group-ec2"
  subnet_ids = [
    "subnet-0ae3b6e2bb8033932",
    "subnet-0b63401edfbc7267f",
    "subnet-052c17d2323a2f8e1"
  ]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  instance_types = ["t3.medium"]
  disk_size      = 20

  ami_type = "AL2023_x86_64_STANDARD"

  tags = {
    Name = "GadgetSphere-node-group"
  }

  depends_on = [aws_eks_cluster.eks, data.aws_iam_role.eks_node_role]
}

data "aws_iam_role" "eks_node_role" {
  name = "node-group-ec2"
}

