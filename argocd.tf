resource "helm_release" "argocd" {
  depends_on = [aws_eks_node_group.gadget_nodes]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.1.2"

  namespace = "argocd"

  create_namespace = true

  set = [
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    }
  ]


}
