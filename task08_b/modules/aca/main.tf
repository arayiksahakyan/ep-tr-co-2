resource "azurerm_user_assigned_identity" "app" {
  name                = "${var.name}-id"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_access_policy" "app" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.app.principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_user_assigned_identity.app.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_app_environment" "main" {
  name                = var.environment.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  workload_profile {
    name                  = var.workload_profile_name
    workload_profile_type = var.workload_profile_type
  }
}

resource "azurerm_container_app" "main" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"
  workload_profile_name        = var.workload_profile_name
  tags                         = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app.id]
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.app.id
  }

  secret {
    name                = "redis-url"
    identity            = azurerm_user_assigned_identity.app.id
    key_vault_secret_id = var.redis_hostname_secret_id
  }

  secret {
    name                = "redis-key"
    identity            = azurerm_user_assigned_identity.app.id
    key_vault_secret_id = var.redis_password_secret_id
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 8080
    transport                  = "http"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "devops"
      image  = "${var.acr_login_server}/${var.app_image_name}:${var.image_tag}"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "CREATOR"
        value = "ACA"
      }

      env {
        name  = "REDIS_PORT"
        value = "6379"
      }

      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }

      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }
    }
  }

  depends_on = [
    azurerm_key_vault_access_policy.app,
    azurerm_role_assignment.acr_pull,
  ]
}
