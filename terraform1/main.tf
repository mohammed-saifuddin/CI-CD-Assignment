provider "aws" {
  region = "ap-south-1"
}
data "aws_secretsmanager_secret_version" "github_token" {
  secret_id = "github-oauth-token"
}
locals {
  github_oauth_token = data.aws_secretsmanager_secret_version.github_token.secret_id
}

terraform {
  required_version = ">= 1.3.0"
  backend "s3" {
    bucket = "my-backend-1234"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
module "infra" {
  source            = "./modules/infrastructure"
  vpc_cidr          = var.vpc_cidr
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
  availability_zones = var.availability_zones
  instance_type     = var.instance_type
  key_name          = var.key_name
}


module "cicd" {
  source = "./modules/cicd"
  github_oauth_token    = local.github_oauth_token
  artifact_bucket_name = var.artifact_bucket_name
}

module "deploy"{
  source = "./modules/deploy"
}
