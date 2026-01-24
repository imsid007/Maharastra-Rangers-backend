# -----------------------------------------------------------------------------
# Secrets Manager Module - Store Environment Variables
# -----------------------------------------------------------------------------

resource "aws_secretsmanager_secret" "app_secrets" {
  name                    = "${var.name_prefix}-app-secrets"
  description             = "Application secrets and environment variables for ${var.name_prefix}"
  recovery_window_in_days = 7

  tags = {
    Name        = "${var.name_prefix}-app-secrets"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "app_secrets" {
  secret_id = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode(merge(
    {
      NODE_ENV = var.environment
      PORT     = "3000"
    },
    var.secrets
  ))
}
