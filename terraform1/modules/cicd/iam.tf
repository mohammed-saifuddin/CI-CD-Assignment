resource "aws_iam_role_policy" "codepipeline_s3_access" {
  name = "codepipeline-s3-access"
  role = aws_iam_role.codepipeline_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
       
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          
          
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy" "codebuild_s3_access" {
  name = "CodeBuildS3AccessPolicy"
  role = aws_iam_role.codebuild_role1.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetBucketLocation"
        ],
        Resource = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}



resource "aws_iam_role_policy" "codebuild_logs_policy" {
  name = "CodeBuildCloudWatchLogsPolicy"
  role = aws_iam_role.codebuild_role1.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
       {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
resource "aws_iam_role" "codedeploy_role" {
  name = "CodeDeployServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "codedeploy.amazonaws.com",
            "codepipeline.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

 
}
resource "aws_iam_role_policy_attachment" "code_deploy_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

resource "aws_iam_role_policy_attachment" "codebuild_logs_policy1" {
  role = aws_iam_role.codebuild_role1.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineServiceRoles"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy" "codebuild_permissions" {
  name = "codebuild-permissions"
  role = aws_iam_role.codebuild_role1.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          # Secrets Manager
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",

          # S3
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation",
          "s3:ListBucket",

          # CodeDeploy
          "codedeploy:GetApplication",
          "codedeploy:ListApplications",
          "codedeploy:GetDeploymentGroup",
          "codedeploy:ListDeploymentGroups",
          "codedeploy:CreateDeployment",
          "codedeploy:GetDeployment",

          # CodePipeline
          "codepipeline:GetPipeline",
          "codepipeline:GetPipelineExecution",

          # EC2/VPC
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeAddresses",
          "ec2:DescribeAddressesAttribute",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:DescribeAvailabilityZones",

          # IAM
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:PassRole",

          # ECR
          "ecr:DescribeRepositories",
          "ecr:GetAuthorizationToken",

          # Logs (optional but useful)
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}






resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "CodePipelinePolicy"
  role = aws_iam_role.codepipeline_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ],
        Resource = "arn:aws:codebuild:ap-south-1:129783607175:project/app-build-project"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:*"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "codedeploy:*"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}
# resource "aws_iam_role" "codebuild_role1" {
#   name = "codebuild-role1"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "codebuild.amazonaws.com"
          
#         },
#          Action = [
#           "iam:GetRolePolicy",
#           "iam:GetRole",
#           "iam:ListRolePolicies",
#           "iam:PassRole",
          
#           "codedeploy:ListTagsForResource",
#           "s3:GetBucketPolicy",
#           "ec2:DescribeLaunchTemplateVersions",
#           "ec2:DescribeVpcAttribute",
#           "ec2:DescribeAddressesAttribute"
#         ],
        
#       }
#     ]
#   })
# }

resource "aws_iam_role" "codebuild_role1" {
  name = "codebuild-role1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
