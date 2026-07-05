variable "acr_login_server" {
  description = "Azure Container Registry login server."
  type        = string
}

variable "aks_kv_access_identity_id" {
  description = "Client ID of the AKS Key Vault Secrets Provider managed identity."
  type        = string
}

variable "app_image_name" {
  description = "Docker image repository name."
  type        = string
}

variable "deployment_template_path" {
  description = "Path to the Kubernetes deployment template."
  type        = string
}

variable "image_tag" {
  description = "Docker image tag."
  type        = string
}

variable "kv_name" {
  description = "Key Vault name."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for application resources."
  type        = string
  default     = "default"
}

variable "redis_password_secret_name" {
  description = "Key Vault secret name for Redis password."
  type        = string
}

variable "redis_url_secret_name" {
  description = "Key Vault secret name for Redis hostname."
  type        = string
}

variable "secret_provider_template_path" {
  description = "Path to the SecretProviderClass template."
  type        = string
}

variable "service_manifest_path" {
  description = "Path to the Kubernetes Service manifest."
  type        = string
}

variable "service_name" {
  description = "Kubernetes Service name."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
}
