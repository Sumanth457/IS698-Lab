terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1 VPC Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

# 2 EC2 Module (Web Server)
module "ec2" {
  source         = "./modules/ec2"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.private_subnet_id
  ami_id         = "ami-0bdd88bd06d16ba03"  
  instance_type  = "t3.micro"
}

# 3 Storage Module (S3 + DynamoDB)
module "storage" {
  source       = "./modules/s3"
  bucket_name  = "hw2-static-${random_id.suffix.hex}"
  table_name   = "user-login-details"
  hash_key     = "username"
}

# Random suffix to avoid duplicate bucket names
resource "random_id" "suffix" {
  byte_length = 4
}

