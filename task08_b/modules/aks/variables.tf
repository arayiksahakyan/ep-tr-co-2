variable "acr_id" {
  description = "Azure Container Registry resource ID."
  type        = string
}

variable "default_node_pool_name" {
  description = "Default AKS node pool name."
  type        = string
}

variable "default_node_pool_node_count" {
  description = "Default AKS node pool node count."
  type        = number
}

variable "default_node_pool_os_disk_size_gb" {
  description = "Default AKS node pool OS disk size in GB."
  type        = number
  default     = 30
}

variable "default_node_pool_os_disk_type" {
  description = "Default AKS node pool OS disk type."
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Default AKS node pool VM size."
  type        = string
}

variable "dns_prefix" {
  description = "AKS DNS prefix."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID used by the CSI Secret Store driver."
  type        = string
}

variable "location" {
  description = "Azure region for AKS."
  type        = string
}

variable "name" {
  description = "AKS cluster name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "tags" {
  description = "Tags to apply to AKS."
  type        = map(string)
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
}
