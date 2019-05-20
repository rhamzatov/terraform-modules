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
  source        = "./modules/patterns/sns_to_sqs_with_dlq"
  name          = "${module.label.id}"
  delay_seconds = 60
  tags          = "${module.label.tags}"

  providers = {
    aws = "aws"
  }
}

output out1 {
  value = "${module.test.sns_arn}"
}

output out2 {
  value = "${module.test.sqs_arn}"
}

output out3 {
  value = "${module.test.dlq_arn}"
}
