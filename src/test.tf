variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  region = "${var.region}"
}

module "label" {
  source      = "./modules/resources/label"
  application = "backoffice"
  name        = "spa"
  environment = "test"
  attributes  = ["experimental"]
  service     = "Customer Care"
  cost_center = "3600"
  team        = "customer care technology"
}

module "test" {
  source = "./modules/patterns/sqs_with_dlq"
  name   = "${module.label.id}"
  tags   = "${module.label.tags}"

  providers = {
    aws = "aws"
  }
}

output out1 {
  value = "${module.test.arn}"
}
