variable "github_oauth_token" {
  description = "GitHub OAuth token to connect CodePipeline with GitHub"
  type        = string
  sensitive   = true
}
variable "artifact_bucket_name" {
  description = "Name of the S3 bucket used for storing CodeBuild artifacts"
  type        = string
}
