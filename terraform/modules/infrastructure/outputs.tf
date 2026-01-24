# -----------------------------------------------------------------------------
# Infrastructure Module Outputs
# -----------------------------------------------------------------------------

# VPC
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

# EC2
output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2.private_ip
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.public_ip
}

# Secrets Manager
output "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = module.secrets_manager.secret_arn
}

output "secrets_manager_name" {
  description = "Name of the Secrets Manager secret"
  value       = module.secrets_manager.secret_name
}

# CodePipeline
output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = module.codepipeline.pipeline_name
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = module.codebuild.project_name
}

# CodeStar Connection
output "codestar_connection_arn" {
  description = "ARN of the CodeStar connection"
  value       = module.codestar_connection.connection_arn
}

output "codestar_connection_status" {
  description = "Status of the CodeStar connection"
  value       = module.codestar_connection.connection_status
}

# Instructions
output "instructions" {
  description = "Post-deployment instructions"
  value       = <<-EOT
    
    ============================================
    DEPLOYMENT COMPLETE
    ============================================
    
    EC2 Public IP: ${module.ec2.public_ip}
    
    Access your app at:
    - http://${module.ec2.public_ip}:3000
    
    GoDaddy DNS Setup (A Record):
    - Type: A
    - Name: api (or your subdomain)
    - Value: ${module.ec2.public_ip}
    
    CodeStar Connection Status: ${module.codestar_connection.connection_status}
    
    If CodeStar status is PENDING:
    1. Go to AWS Console -> Developer Tools -> Connections
    2. Click "Update pending connection"
    3. Authorize GitHub access
    
    Access EC2 via SSM:
    aws ssm start-session --target ${module.ec2.instance_id}
    
    ============================================
    
  EOT
}
