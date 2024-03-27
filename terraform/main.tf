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

module "elb" {
  source = "./modules/elb"
  vpc = module.vpc.vpc
  load_balancer_sg = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.elb_a
  load_balancer_subnet_b = module.vpc.elb_b
  load_balancer_subnet_c = module.vpc.elb_c
}

module "iam" {
  source = "./modules/iam"
  ecr_repo = var.ecr_repo
  elb = module.elb.elb
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
  ecs_target_group = module.elb.ecs_target_group
  ecs_subnet_a = module.vpc.ecs_a
  ecs_subnet_b = module.vpc.ecs_b
  ecs_subnet_c = module.vpc.ecs_c
  ecs_sg = module.vpc.ecs_sg
  ecs_role = module.iam.ecs_role
}

module "auto_scaling" {
  source = "./modules/auto-scaling"
  ecs_cluster = module.ecs.ecs_cluster
  ecs_service = module.ecs.ecs_service
}
