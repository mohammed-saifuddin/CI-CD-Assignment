resource "aws_s3_bucket" "artifacts" {
  bucket = "codepipeline-artifacts-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_ecr_repository" "app" {
  name = "dockerized-web-app"
}