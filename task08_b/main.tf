data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_resource_provider_registration" "microsoft_app" {
  name = "Microsoft.App"
}

module "keyvault" {
  source = "./modules/keyvault"

  current_user_object_id = data.azurerm_client_config.current.object_id
  location               = azurerm_resource_group.main.location
  name                   = local.keyvault_name
  resource_group_name    = azurerm_resource_group.main.name
  sku_name               = "standard"
  tags                   = local.common_tags
  tenant_id              = data.azurerm_client_config.current.tenant_id
}

module "storage" {
  source = "./modules/storage"

  account_replication_type = "LRS"
  application_source_dir   = "${path.module}/application"
  archive_blob_name        = local.app_archive_blob_name
  container_access_type    = "private"
  container_name           = local.app_storage_container_name
  location                 = azurerm_resource_group.main.location
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.main.name
  tags                     = local.common_tags
}

module "aci_redis" {
  source = "./modules/aci_redis"

  dns_name_label             = local.redis_aci_name
  key_vault_id               = module.keyvault.id
  location                   = azurerm_resource_group.main.location
  name                       = local.redis_aci_name
  redis_hostname_secret_name = local.redis_hostname_secret_name
  redis_password_secret_name = local.redis_password_secret_name
  resource_group_name        = azurerm_resource_group.main.name
  sku                        = "Standard"
  tags                       = local.common_tags

  depends_on = [module.keyvault]
}

module "acr" {
  source = "./modules/acr"

  context_access_token = module.storage.container_sas_token
  context_path         = module.storage.app_blob_url
  image_name           = local.app_image_name
  image_tag            = local.app_image_tag
  location             = azurerm_resource_group.main.location
  name                 = local.acr_name
  resource_group_name  = azurerm_resource_group.main.name
  sku                  = "Basic"
  tags                 = local.common_tags

  depends_on = [module.storage]
}

module "aca" {
  source = "./modules/aca"

  acr_id                   = module.acr.id
  acr_login_server         = module.acr.login_server
  app_image_name           = local.app_image_name
  image_tag                = local.app_image_tag
  key_vault_id             = module.keyvault.id
  location                 = azurerm_resource_group.main.location
  name                     = local.aca_name
  redis_hostname_secret_id = module.aci_redis.redis_hostname_secret_versionless_id
  redis_password_secret_id = module.aci_redis.redis_password_secret_versionless_id
  resource_group_name      = azurerm_resource_group.main.name
  tags                     = local.common_tags
  tenant_id                = data.azurerm_client_config.current.tenant_id
  workload_profile_name    = "Consumption"
  workload_profile_type    = "Consumption"

  environment = {
    name = local.aca_env_name
  }

  depends_on = [
    azurerm_resource_provider_registration.microsoft_app,
    module.acr,
    module.aci_redis,
  ]
}

module "aks" {
  source = "./modules/aks"

  acr_id                         = module.acr.id
  default_node_pool_name         = local.aks_default_node_pool_name
  default_node_pool_node_count   = local.aks_default_node_pool_node_count
  default_node_pool_os_disk_type = local.aks_default_node_pool_os_disk_type
  default_node_pool_vm_size      = local.aks_default_node_pool_vm_size
  dns_prefix                     = local.aks_name
  key_vault_id                   = module.keyvault.id
  location                       = azurerm_resource_group.main.location
  name                           = local.aks_name
  resource_group_name            = azurerm_resource_group.main.name
  tags                           = local.common_tags
  tenant_id                      = data.azurerm_client_config.current.tenant_id

  depends_on = [
    module.acr,
    module.aci_redis,
  ]
}

module "k8s" {
  source = "./modules/k8s"

  acr_login_server              = module.acr.login_server
  aks_kv_access_identity_id     = module.aks.key_vault_secrets_provider_client_id
  app_image_name                = local.app_image_name
  deployment_template_path      = "${path.module}/k8s-manifests/deployment.yaml.tftpl"
  image_tag                     = local.app_image_tag
  kv_name                       = module.keyvault.name
  redis_password_secret_name    = local.redis_password_secret_name
  redis_url_secret_name         = local.redis_hostname_secret_name
  secret_provider_template_path = "${path.module}/k8s-manifests/secret-provider.yaml.tftpl"
  service_manifest_path         = "${path.module}/k8s-manifests/service.yaml"
  service_name                  = "redis-flask-app-service"
  tenant_id                     = data.azurerm_client_config.current.tenant_id

  depends_on = [
    module.acr,
    module.aks,
    module.aci_redis,
  ]
}
