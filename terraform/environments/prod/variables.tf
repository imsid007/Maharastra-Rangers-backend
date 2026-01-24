# -----------------------------------------------------------------------------
# Production Environment Variables
# -----------------------------------------------------------------------------

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "maharastra-rangers"
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# EC2
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.nano"
}

variable "key_name" {
  description = "Name of the SSH key pair (optional)"
  type        = string
  default     = ""
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
  default     = 3000
}

# GitHub
variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to deploy from"
  type        = string
  default     = "main"
}

# Secrets
variable "app_secrets" {
  description = "Application secrets to store in Secrets Manager"
  type        = map(string)
  default     = {}
  sensitive   = true
}
