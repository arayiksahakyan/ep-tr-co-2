output "app_blob_url" {
  description = "URL of the uploaded application archive blob."
  value       = azurerm_storage_blob.application_archive.url
}

output "archive_hash" {
  description = "Hash of the generated application archive."
  value       = data.archive_file.application.output_base64sha256
}

output "container_sas_token" {
  description = "SAS token for the storage container without a leading question mark."
  sensitive   = true
  value       = replace(data.azurerm_storage_account_blob_container_sas.app.sas, "/^\\?/", "")
}

output "storage_account_id" {
  description = "Storage Account resource ID."
  value       = azurerm_storage_account.main.id
}
