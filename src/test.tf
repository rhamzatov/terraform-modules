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

