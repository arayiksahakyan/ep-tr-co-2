variable "creator" {
  description = "Creator tag value applied to task resources."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "aca_location" {
  description = "Azure region for Azure Container Apps resources. Defaults to location."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix used to derive task resource names."
  type        = string
}
