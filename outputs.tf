output "argocd_server_url" {
  value       = "kubectl get svc argocd-server -n argocd"
  description = "Command to get the ArgoCD server LoadBalancer URL"
}

output "argocd_initial_password" {
  value       = "argocd admin initial-password -n argocd"
  description = "Command to get the ArgoCD initial admin password"
}
