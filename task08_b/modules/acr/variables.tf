variable "context_access_token" {
  description = "SAS token for ACR Task source context."
  sensitive   = true
  type        = string
}

variable "context_path" {
  description = "Blob URL for the ACR Task source context archive."
  type        = string
}

variable "image_name" {
  description = "Docker image repository name."
  type        = string
}

variable "image_tag" {
  description = "Docker image tag."
  type        = string
}

variable "location" {
  description = "Azure region for the ACR."
  type        = string
}

variable "name" {
  description = "Azure Container Registry name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "sku" {
  description = "Azure Container Registry SKU."
  type        = string
}

variable "tags" {
  description = "Tags to apply to ACR resources."
  type        = map(string)
}
