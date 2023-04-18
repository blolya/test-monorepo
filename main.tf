terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-3"
}

data "aws_caller_identity" "current" {}

module "iam" {
  source = "./modules/iam"
}

module "lambdas" {
  source = "./modules/lambdas"
  role_arn = module.iam.role_arn
  depends_on = [module.iam]
}

module "api" {
  source = "./modules/api"
  invoke_arn_cars = module.lambdas.invoke_arn_cars
  account_id = data.aws_caller_identity.current.account_id
  region = "eu-west-3"
  depends_on = [module.lambdas]
}

