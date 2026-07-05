variable "dns_name_label" {
  description = "DNS label for the Redis container group."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID where Redis connection secrets are stored."
  type        = string
}

variable "location" {
  description = "Azure region for the Redis container group."
  type        = string
}

variable "name" {
  description = "Redis container group name."
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Key Vault secret name for Redis hostname."
  type        = string
}

variable "redis_image" {
  description = "Redis container image from Microsoft Artifact Registry."
  type        = string
  default     = "mcr.microsoft.com/cbl-mariner/base/redis:6.2"
}

variable "redis_password_secret_name" {
  description = "Key Vault secret name for Redis password."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "sku" {
  description = "Azure Container Instance SKU."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Redis container group."
  type        = map(string)
}
