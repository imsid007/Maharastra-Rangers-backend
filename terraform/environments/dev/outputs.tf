# -----------------------------------------------------------------------------
# Development Environment Outputs
# -----------------------------------------------------------------------------

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.infrastructure.ec2_instance_id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance (use for GoDaddy A record)"
  value       = module.infrastructure.ec2_public_ip
}

output "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = module.infrastructure.secrets_manager_arn
}

output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = module.infrastructure.codepipeline_name
}

output "codestar_connection_status" {
  description = "Status of the CodeStar connection"
  value       = module.infrastructure.codestar_connection_status
}

output "instructions" {
  description = "Post-deployment instructions"
  value       = module.infrastructure.instructions
}
