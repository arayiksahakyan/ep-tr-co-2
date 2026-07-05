output "id" {
  description = "AKS cluster resource ID."
  value       = azurerm_kubernetes_cluster.main.id
}

output "key_vault_secrets_provider_client_id" {
  description = "Client ID of the AKS Key Vault Secrets Provider managed identity."
  value       = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "kube_config" {
  description = "Kubernetes provider connection details."
  sensitive   = true
  value = {
    client_certificate     = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.main.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
    host                   = azurerm_kubernetes_cluster.main.kube_config[0].host
  }
}

output "name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.main.name
}
