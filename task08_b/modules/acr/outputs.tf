output "id" {
  description = "Azure Container Registry resource ID."
  value       = azurerm_container_registry.main.id
}

output "login_server" {
  description = "Azure Container Registry login server."
  value       = azurerm_container_registry.main.login_server
}

output "task_schedule_run_id" {
  description = "ID of the ACR task schedule run."
  value       = azurerm_container_registry_task_schedule_run_now.build.id
}
