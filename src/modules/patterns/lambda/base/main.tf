module "fromS3" {
  count                     = "${var.filepath == "" ? 1 : 0}"
  source                    = "../../../resources/lambda/fromS3"
  name                      = "${var.name}"
  description               = "${var.description}"
  role_arn                  = "${var.role_arn}"
  s3_bucket_name            = "${var.s3_bucket_name}"
  s3_bucket_path            = "${var.s3_bucket_path}"
  handler                   = "${var.handler}"
  runtime                   = "${var.runtime}"
  memory_size               = "${var.memory_size}"
  timeout                   = "${var.timeout}"
  max_concurrent_executions = "${var.max_concurrent_executions}"
  variables                 = "${var.variables}"
  tags                      = "${var.tags}"
}

data "archive_file" "zip" {
  count       = "${var.filepath != "" ? 1 : 0}"
  type        = "zip"
  source_file = "${var.filepath}"
  output_path = "${path.cwd}/publish/package.zip"
}

module "fromFile" {
  count                     = "${var.filepath != "" ? 1 : 0}"
  source                    = "../../../resources/lambda/fromFile"
  name                      = "${var.name}"
  description               = "${var.description}"
  role_arn                  = "${var.role_arn}"
  filepath                  = "${path.cwd}/publish/package.zip"
  handler                   = "${var.handler}"
  runtime                   = "${var.runtime}"
  memory_size               = "${var.memory_size}"
  timeout                   = "${var.timeout}"
  max_concurrent_executions = "${var.max_concurrent_executions}"
  variables                 = "${var.variables}"
  tags                      = "${var.tags}"
}
