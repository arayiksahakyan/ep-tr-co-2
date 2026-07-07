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
}

resource "azurerm_resource_group_template_deployment" "clear_recovered_access_policies" {
  name                = "${var.name}-clear-access-policies"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = jsonencode({
    "$schema"      = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
    contentVersion = "1.0.0.0"
    resources = [
      {
        type       = "Microsoft.KeyVault/vaults/accessPolicies"
        apiVersion = "2023-07-01"
        name       = "${azurerm_key_vault.main.name}/replace"
        properties = {
          accessPolicies = []
        }
      }
    ]
  })
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.current_user_object_id

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

  depends_on = [azurerm_resource_group_template_deployment.clear_recovered_access_policies]
}
