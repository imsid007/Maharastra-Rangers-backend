variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets for ALB"
  type        = list(string)
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
}

variable "ec2_instance_id" {
  description = "ID of the EC2 instance to register with target group"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS (optional)"
  type        = string
  default     = ""
}
