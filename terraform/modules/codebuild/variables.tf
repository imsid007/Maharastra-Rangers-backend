variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "codebuild_role_arn" {
  description = "ARN of the CodeBuild IAM role"
  type        = string
}

variable "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets"
  type        = list(string)
}

variable "ec2_security_group_id" {
  description = "ID of the EC2 security group"
  type        = string
}
