data "archive_file" "application" {
  type        = "tar.gz"
  source_dir  = var.application_source_dir
  output_path = "${path.module}/${var.archive_blob_name}"
}

resource "time_static" "sas_start" {}

resource "time_offset" "sas_expiry" {
  base_rfc3339 = time_static.sas_start.rfc3339
  offset_years = 1
}

resource "azurerm_storage_account" "main" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  account_tier                    = "Standard"
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  tags                            = var.tags
}

resource "azurerm_storage_container" "app" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "application_archive" {
  name                   = var.archive_blob_name
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.app.name
  type                   = "Block"
  source                 = data.archive_file.application.output_path
  content_md5            = data.archive_file.application.output_md5
  content_type           = "application/gzip"
}

data "azurerm_storage_account_blob_container_sas" "app" {
  connection_string = azurerm_storage_account.main.primary_connection_string
  container_name    = azurerm_storage_container.app.name
  https_only        = true
  start             = time_static.sas_start.rfc3339
  expiry            = time_offset.sas_expiry.rfc3339

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = true
  }

  depends_on = [azurerm_storage_blob.application_archive]
}
