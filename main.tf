terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "terraform-xh7mt96eu0"
    key    = "state"
    region = "eu-west-3"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-3"
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source = "./modules/vpc"
}
module "rds" {
  source = "./modules/rds"
  depends_on = [module.vpc]
  vpc_security_group_id = module.vpc.vpc_security_group_id
  db_name = var.DB_NAME
  db_user = var.DB_USER
  db_password = var.DB_PASSWORD
}

module "iam" {
  source = "./modules/iam"
}

module "lambdas" {
  source = "./modules/lambdas"
  role_arn = module.iam.role_arn
  webflow_auth_token = var.WEBFLOW_AUTH_TOKEN
  site_id = var.SITE_ID
  depends_on = [module.iam]
}

module "api" {
  source = "./modules/api"
  invoke_arn_webflow-request-authorizer = module.lambdas.invoke_arn_webflow-request-authorizer
  invoke_arn_cars = module.lambdas.invoke_arn_cars
  role_arn = module.iam.role_arn
  account_id = data.aws_caller_identity.current.account_id
  region = "eu-west-3"
  depends_on = [module.lambdas]
}

