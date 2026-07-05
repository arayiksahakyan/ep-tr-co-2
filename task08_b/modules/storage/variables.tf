variable "account_replication_type" {
  description = "Storage account replication type."
  type        = string
}

variable "application_source_dir" {
  description = "Path to the application directory to archive."
  type        = string
}

variable "archive_blob_name" {
  description = "Name of the uploaded application archive blob."
  type        = string
}

variable "container_access_type" {
  description = "Access level for the storage container."
  type        = string
}

variable "container_name" {
  description = "Name of the storage container."
  type        = string
}

variable "location" {
  description = "Azure region for the Storage Account."
  type        = string
}

variable "name" {
  description = "Storage Account name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Storage Account."
  type        = map(string)
}
