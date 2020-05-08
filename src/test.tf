variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  region = var.region
}

module "label" {
  source      = "./modules/resources/label"
  application = "backoffice"
  name        = "spa"
  environment = "test"
  attributes  = ["experimental"]
  domain      = "ci-cd platform"
  cost_center = "3600"
  team        = "customer care technology"
}

data "aws_vpc" "main" {
  tags = {
    Name = "sandbox_vpc"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "private-*"
  }
}
module "security_group" {
  source       = "./modules/patterns/security_group/can_access_albelli_networks"
  name         = module.label.id_without_env
  vpc_id       = data.aws_vpc.main.id
  extra_ranges = ["213.127.62.87/32"]
  tags         = module.label.tags
}

module "test" {
  source              = "./modules/patterns/lambda/scheduled"
  name                = module.label.id_without_env
  handler             = "Connectors.Zendesk.Customer::Connectors.Zendesk.Customer.Function::FunctionHandler"
  s3_bucket_name      = "cct-artifacts-t"
  memory_size         = 512
  timeout             = 59
  log_retention_days  = 14
  schedule_expression = "rate(1 minutes)"

  variables = {
    env1 = "var1"
    env2 = "var2"
  }

  vpc_config = {
    subnet_ids         = data.aws_subnet_ids.private.ids
    security_group_ids = [module.security_group.id]
  }

  tags = module.label.tags

  providers = {
    aws = aws
  }
}

output "out1" {
  value = module.test.lambda_arn
}

output "out2" {
  value = module.test.role_arn
}

output "out3" {
  value = module.test.role_name
}
