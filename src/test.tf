variable "region" {
  default = "eu-west-1"
}

provider "aws" {
  region = "${var.region}"
}

module "test" {
  source         = "./modules/resources/lambda/plain"
  name           = "test111"
  role_arn       = "arn:aws:iam::884394444434:role/backoffice_lambda"
  handler        = "test"
  s3_bucket_name = "cct-lambda-storage"
  s3_bucket_path = "dotnet_sample.zip"

  providers = {
    aws = "aws"
  }
}

output out1 {
  value = "${module.test.arn}"
}
