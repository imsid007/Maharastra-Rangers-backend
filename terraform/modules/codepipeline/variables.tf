variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "ARN of the CodePipeline IAM role"
  type        = string
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to deploy from"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN of the CodeStar connection to GitHub"
  type        = string
}
