variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair (optional)"
  type        = string
  default     = ""
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2"
  type        = string
}

variable "aws_region" {
  description = "AWS region for CodeDeploy agent download"
  type        = string
  default     = "ap-south-1"
}
