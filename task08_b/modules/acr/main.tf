resource "azurerm_container_registry" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}

resource "azurerm_container_registry_task" "build" {
  name                  = "${var.image_name}-build"
  container_registry_id = azurerm_container_registry.main.id
  timeout_in_seconds    = 3600
  tags                  = var.tags

  platform {
    os           = "Linux"
    architecture = "amd64"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.context_path
    context_access_token = var.context_access_token
    image_names          = ["${var.image_name}:${var.image_tag}"]
    push_enabled         = true
    cache_enabled        = true
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "build" {
  container_registry_task_id = azurerm_container_registry_task.build.id
}
