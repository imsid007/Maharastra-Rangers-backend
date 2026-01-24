variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret"
  type        = string
}
