output "redis_fqdn" {
  description = "FQDN of the Redis Azure Container Instance."
  value       = azurerm_container_group.redis.fqdn
}

output "redis_hostname_secret_versionless_id" {
  description = "Versionless Key Vault secret ID for the Redis hostname."
  value       = azurerm_key_vault_secret.redis_hostname.versionless_id
}

output "redis_ip_address" {
  description = "Public IP address of the Redis Azure Container Instance."
  value       = azurerm_container_group.redis.ip_address
}

output "redis_password_secret_versionless_id" {
  description = "Versionless Key Vault secret ID for the Redis password."
  sensitive   = true
  value       = azurerm_key_vault_secret.redis_password.versionless_id
}
