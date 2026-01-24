output "secret_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.app_secrets.arn
}

output "secret_name" {
  description = "Name of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.app_secrets.name
}

output "secret_id" {
  description = "ID of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.app_secrets.id
}
