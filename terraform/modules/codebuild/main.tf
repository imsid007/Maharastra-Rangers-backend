# -----------------------------------------------------------------------------
# CodeBuild Module - Build and Deploy Application
# -----------------------------------------------------------------------------

# S3 Bucket for build artifacts
resource "aws_s3_bucket" "codebuild" {
  bucket = "${var.name_prefix}-codebuild-artifacts"

  tags = {
    Name = "${var.name_prefix}-codebuild-artifacts"
  }
}

resource "aws_s3_bucket_versioning" "codebuild" {
  bucket = aws_s3_bucket.codebuild.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codebuild" {
  bucket = aws_s3_bucket.codebuild.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# CloudWatch Log Group for CodeBuild
resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/aws/codebuild/${var.name_prefix}-build"
  retention_in_days = 14

  tags = {
    Name = "${var.name_prefix}-codebuild-logs"
  }
}

# CodeBuild Project
resource "aws_codebuild_project" "main" {
  name          = "${var.name_prefix}-build"
  description   = "Build project for ${var.name_prefix}"
  service_role  = var.codebuild_role_arn
  build_timeout = 30

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false

    environment_variable {
      name  = "ENVIRONMENT"
      value = var.environment
    }

    environment_variable {
      name  = "SECRETS_ARN"
      value = var.secrets_manager_arn
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = data.aws_region.current.name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  # Enable local caching for faster builds
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_SOURCE_CACHE", "LOCAL_CUSTOM_CACHE"]
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild.name
      stream_name = "build-log"
    }
  }

  # VPC config removed - not needed for simple npm builds
  # Removing this saves 2-5 minutes per build (ENI setup time)
  # Uncomment if you need VPC access during build (e.g., private npm registry)
  # vpc_config {
  #   vpc_id             = var.vpc_id
  #   subnets            = var.public_subnet_ids
  #   security_group_ids = [var.ec2_security_group_id]
  # }

  tags = {
    Name        = "${var.name_prefix}-build"
    Environment = var.environment
  }
}

data "aws_region" "current" {}
