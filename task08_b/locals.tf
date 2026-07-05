locals {
  aca_env_name   = "${var.name_prefix}-cae"
  aca_name       = "${var.name_prefix}-ca"
  acr_name       = "${replace(var.name_prefix, "-", "")}cr"
  aks_name       = "${var.name_prefix}-aks"
  keyvault_name  = "${var.name_prefix}-kv"
  redis_aci_name = "${var.name_prefix}-redis-ci"
  rg_name        = "${var.name_prefix}-rg"
  sa_name        = "${replace(var.name_prefix, "-", "")}sa"

  app_image_name             = "${var.name_prefix}-app"
  app_image_tag              = "latest"
  app_archive_blob_name      = "app-content.tar.gz"
  app_storage_container_name = "app-content"

  aks_default_node_pool_name         = "system"
  aks_default_node_pool_node_count   = 1
  aks_default_node_pool_vm_size      = "Standard_D2ads_v6"
  aks_default_node_pool_os_disk_type = "Ephemeral"

  redis_hostname_secret_name = "redis-hostname"
  redis_password_secret_name = "redis-password"

  common_tags = {
    Creator = var.creator
  }
}
