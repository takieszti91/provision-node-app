terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
  ecr_repo = var.ecr_repo
}

module "ecr" {
  source = "./modules/ecr"
  aws_account = var.aws_account
  aws_region = var.aws_region
  ecr_repo = var.ecr_repo
}

module "ecs" {
  source = "./modules/ecs"
  aws_account = var.aws_account
  aws_region = var.aws_region
  ecr_repo = var.ecr_repo
  public_a = module.vpc.public_a
  public_b = module.vpc.public_b
  security_group_node_app = module.vpc.security_group_node_app
  ecs_role = module.iam.ecs_role
}
