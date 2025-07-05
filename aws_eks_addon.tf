resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.33.0-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "coredns"
  addon_version               = "v1.12.1-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.19.5-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.3.7-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "node_monitoring" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "eks-node-monitoring-agent"
  addon_version               = "v1.3.0-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "metrics-server"
  addon_version               = "v0.7.2-eksbuild.4"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "external_dns" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "external-dns"
  addon_version               = "v0.17.0-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.45.0-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}

resource "aws_eks_addon" "aws-efs-csi-driver" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = "aws-efs-csi-driver"
  addon_version               = "v2.1.8-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on                  = [aws_eks_cluster.eks, aws_eks_node_group.gadget_nodes]
}
