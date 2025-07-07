provider "aws" {
  region = "eu-west-1"
}

data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "eks" {
  name       = aws_eks_cluster.eks.name
  depends_on = [aws_eks_cluster.eks]
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

resource "local_file" "kubeconfig" {
  content = templatefile("${path.module}/kubeconfig.tpl", {
    endpoint            = aws_eks_cluster.eks.endpoint
    cluster_auth_base64 = aws_eks_cluster.eks.certificate_authority[0].data
    token               = data.aws_eks_cluster_auth.eks.token
  })
  filename = "${path.module}/generated_kubeconfig.yaml"

  depends_on = [
    aws_eks_cluster.eks,
    aws_eks_node_group.gadget_nodes
  ]

  lifecycle {
    create_before_destroy = true
  }
}

provider "helm" {
  kubernetes = {
    config_path = local_file.kubeconfig.filename
  }
}

resource "null_resource" "delete_kubeconfig" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${path.module}/generated_kubeconfig.yaml"
  }
}
