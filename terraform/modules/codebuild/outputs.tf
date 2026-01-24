output "project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.main.name
}

output "project_arn" {
  description = "ARN of the CodeBuild project"
  value       = aws_codebuild_project.main.arn
}

output "artifacts_bucket" {
  description = "Name of the artifacts S3 bucket"
  value       = aws_s3_bucket.codebuild.id
}
