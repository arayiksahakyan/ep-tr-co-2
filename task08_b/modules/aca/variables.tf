variable "acr_id" {
  description = "Azure Container Registry resource ID."
  type        = string
}

variable "acr_login_server" {
  description = "Azure Container Registry login server."
  type        = string
}

variable "app_image_name" {
  description = "Docker image repository name."
  type        = string
}

variable "environment" {
  description = "Container App Environment settings."
  type = object({
    name = string
  })
}

variable "image_tag" {
  description = "Docker image tag."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID used by the Container App."
  type        = string
}

variable "location" {
  description = "Azure region for Container App resources."
  type        = string
}

variable "name" {
  description = "Azure Container App name."
  type        = string
}

variable "redis_hostname_secret_id" {
  description = "Versionless Key Vault secret ID for Redis hostname."
  type        = string
}

variable "redis_password_secret_id" {
  description = "Versionless Key Vault secret ID for Redis password."
  sensitive   = true
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "tags" {
  description = "Tags to apply to Container App resources."
  type        = map(string)
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
}

variable "workload_profile_name" {
  description = "Container App workload profile name."
  type        = string
}

variable "workload_profile_type" {
  description = "Container App workload profile type."
  type        = string
}
