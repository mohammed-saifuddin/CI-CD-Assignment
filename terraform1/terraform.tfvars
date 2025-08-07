vpc_cidr         = "10.0.0.0/16"
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["ap-south-1a", "ap-south-1b"]
instance_type    = "t3.micro"
key_name         = "ubuntu"


artifact_bucket_name = "my-artifact-bucket-a7d18a83"
