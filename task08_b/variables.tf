variable "creator" {
  description = "Creator tag value applied to task resources."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used to derive task resource names."
  type        = string
}
