provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.9"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "projetodevopstf"
    key = "states/eks_terraform.tfstate"
    region = "us-east-1"
  }
}

module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks_cluster"
  private_subnet_1a = module.vpc.private_subnet_1a
  private_subnet_1b = module.vpc.private_subnet_1b
  public_subnet_1a = module.vpc.public_subnet_1a
  public_subnet_1b = module.vpc.public_subnet_1b
}
