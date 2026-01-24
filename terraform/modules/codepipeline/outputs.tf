output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.main.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.main.arn
}

output "artifacts_bucket" {
  description = "Name of the pipeline artifacts S3 bucket"
  value       = aws_s3_bucket.pipeline.id
}
