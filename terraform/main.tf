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

module "ecr" {
  source = "./modules/ecr"
  aws_account = var.aws_account
  aws_region = var.aws_region
  ecr_repo = var.ecr_repo
}
