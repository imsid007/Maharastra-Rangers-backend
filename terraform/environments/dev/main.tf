# -----------------------------------------------------------------------------
# Development Environment Configuration
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment to use S3 backend for state management
  # backend "s3" {
  #   bucket         = "maharastra-rangers-terraform-state"
  #   key            = "dev/terraform.tfstate"
  #   region         = "ap-south-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}

# Use shared modules from parent directory
module "infrastructure" {
  source = "../../modules/infrastructure"

  # General
  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = "dev"

  # VPC
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs

  # EC2
  instance_type = var.instance_type
  key_name      = var.key_name
  app_port      = var.app_port

  # GitHub
  github_owner  = var.github_owner
  github_repo   = var.github_repo
  github_branch = var.github_branch

  # Secrets
  app_secrets = var.app_secrets
}
