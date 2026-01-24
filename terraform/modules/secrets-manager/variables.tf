variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "secrets" {
  description = "Map of secret key-value pairs to store"
  type        = map(string)
  default     = {}
  sensitive   = true
}
