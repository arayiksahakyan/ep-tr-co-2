variable "current_user_object_id" {
  description = "Object ID of the current Azure principal."
  type        = string
}

variable "location" {
  description = "Azure region for the Key Vault."
  type        = string
}

variable "name" {
  description = "Key Vault name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Key Vault."
  type        = map(string)
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
}
