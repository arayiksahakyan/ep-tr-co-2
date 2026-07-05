resource "azurerm_key_vault" "main" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = var.sku_name
  enable_rbac_authorization     = false
  purge_protection_enabled      = false
  public_network_access_enabled = true
  soft_delete_retention_days    = 7
  tags                          = var.tags

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.current_user_object_id

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
  }

  lifecycle {
    ignore_changes = [access_policy]
  }
}
