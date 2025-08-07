resource "aws_codebuild_project" "app_build" {
  name          = "app-build-project"
  description   = "Build project for CI/CD"
  build_timeout = 5

  service_role = aws_iam_role.codebuild_role1.arn

  source {
    type = "CODEPIPELINE"
    location        = "https://github.com/mohammed-saifuddin/CI-CD-Assignment.git"
    buildspec = file("${path.root}/../buildspec.yml")
    
  }

  artifacts {
    type = "CODEPIPELINE"
  }

   environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    

}


}

 