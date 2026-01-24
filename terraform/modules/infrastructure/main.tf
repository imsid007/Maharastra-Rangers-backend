# -----------------------------------------------------------------------------
# Infrastructure Module - Wraps all sub-modules
# -----------------------------------------------------------------------------

locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# -----------------------------------------------------------------------------
# CodeStar Connection (GitHub)
# -----------------------------------------------------------------------------
module "codestar_connection" {
  source = "../codestar-connection"

  name_prefix = local.name_prefix
}

# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------
module "vpc" {
  source = "../vpc"

  name_prefix         = local.name_prefix
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
}

# -----------------------------------------------------------------------------
# Secrets Manager
# -----------------------------------------------------------------------------
module "secrets_manager" {
  source = "../secrets-manager"

  name_prefix = local.name_prefix
  environment = var.environment
  secrets     = var.app_secrets
}

# -----------------------------------------------------------------------------
# IAM
# -----------------------------------------------------------------------------
module "iam" {
  source = "../iam"

  name_prefix         = local.name_prefix
  secrets_manager_arn = module.secrets_manager.secret_arn
}

# -----------------------------------------------------------------------------
# EC2 (in public subnet - no ALB)
# -----------------------------------------------------------------------------
module "ec2" {
  source = "../ec2"

  name_prefix          = local.name_prefix
  vpc_id               = module.vpc.vpc_id
  subnet_id            = module.vpc.public_subnet_ids[0]
  instance_type        = var.instance_type
  key_name             = var.key_name
  app_port             = var.app_port
  iam_instance_profile = module.iam.ec2_instance_profile_name
  aws_region           = var.aws_region
}

# -----------------------------------------------------------------------------
# CodeBuild
# -----------------------------------------------------------------------------
module "codebuild" {
  source = "../codebuild"

  name_prefix           = local.name_prefix
  environment           = var.environment
  codebuild_role_arn    = module.iam.codebuild_role_arn
  secrets_manager_arn   = module.secrets_manager.secret_arn
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  ec2_security_group_id = module.ec2.security_group_id
}

# -----------------------------------------------------------------------------
# CodePipeline
# -----------------------------------------------------------------------------
module "codepipeline" {
  source = "../codepipeline"

  name_prefix             = local.name_prefix
  codepipeline_role_arn   = module.iam.codepipeline_role_arn
  codebuild_project_name  = module.codebuild.project_name
  github_owner            = var.github_owner
  github_repo             = var.github_repo
  github_branch           = var.github_branch
  codestar_connection_arn = module.codestar_connection.connection_arn
}
