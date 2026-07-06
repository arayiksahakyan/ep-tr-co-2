output "environment_id" {
  description = "Azure Container App Environment ID."
  value       = azurerm_container_app_environment.main.id
}

output "fqdn" {
  description = "FQDN of the Azure Container App ingress."
  value       = azurerm_container_app.main.ingress[0].fqdn
}

output "id" {
  description = "Azure Container App ID."
  value       = azurerm_container_app.main.id
}

output "identity_id" {
  description = "User-assigned identity ID used by Azure Container App."
  value       = azurerm_user_assigned_identity.app.id
}
