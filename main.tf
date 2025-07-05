provider "aws" {
  region = "eu-west-1"
}



provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

resource "local_file" "kubeconfig" {
  content  = templatefile("${path.module}/kubeconfig.tpl", {
    endpoint            = data.aws_eks_cluster.eks.endpoint
    cluster_auth_base64 = data.aws_eks_cluster.eks.certificate_authority[0].data
    token               = data.aws_eks_cluster_auth.eks.token
  })
  filename = "${path.module}/generated_kubeconfig.yaml"
}

provider "helm" {
  kubernetes = {
    config_path = local_file.kubeconfig.filename
  }
}


data "aws_eks_cluster" "eks" {
  name = "eks-GadgetSphere"
}

data "aws_eks_cluster_auth" "eks" {
  name = "eks-GadgetSphere"
}
