# -----------------------------------------------------------------------------
# CodeStar Connection Module - GitHub Connection
# -----------------------------------------------------------------------------

resource "aws_codestarconnections_connection" "github" {
  name          = "${var.name_prefix}-github"
  provider_type = "GitHub"

  tags = {
    Name = "${var.name_prefix}-github"
  }
}
