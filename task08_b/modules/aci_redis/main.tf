resource "random_password" "redis" {
  length      = 20
  min_lower   = 1
  min_numeric = 1
  min_upper   = 1
  special     = false
}

resource "azurerm_container_group" "redis" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  ip_address_type             = "Public"
  dns_name_label              = var.dns_name_label
  dns_name_label_reuse_policy = "ResourceGroupReuse"
  os_type                     = "Linux"
  restart_policy              = "Always"
  sku                         = var.sku
  tags                        = var.tags

  container {
    name   = "redis"
    image  = var.redis_image
    cpu    = 0.5
    memory = 1.0

    commands = [
      "redis-server",
      "--protected-mode",
      "no",
      "--requirepass",
      random_password.redis.result,
    ]

    ports {
      port     = 6379
      protocol = "TCP"
    }
  }
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = var.redis_password_secret_name
  value        = random_password.redis.result
  key_vault_id = var.key_vault_id
}
