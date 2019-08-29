variable "name" {
  description = "Lambda name"
}

variable "role_arn" {
  description = "Role ARN"
}

variable "handler" {
  description = "The function entrypoint in your code."
}

variable "filepath" {
  default     = ""
  description = "(Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
}

variable "s3_bucket_name" {
  default     = ""
  description = "(Optional) The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function."
}

variable "s3_bucket_path" {
  default     = ""
  description = "(Optional) The S3 key of an object containing the function's deployment package. Conflicts with filename."
}

variable "runtime" {
  default     = "dotnetcore2.1"
  description = "The identifier of the function's runtime."
}

variable "description" {
  default     = ""
  description = "Lambda description"
}

variable "memory_size" {
  default     = "128"
  description = "Amount of memory in MB your Lambda Function can use at runtime."
}

variable "timeout" {
  default     = "3"
  description = "The amount of time your Lambda Function has to run in seconds."
}

variable "variables" {
  type = "map"

  default = {
    ENCODING = "utf-8"
  }
}

variable "logs_arn" {
  default     = ""
  description = "Do not use this variable. It just for proper graph dependency."
}

variable "max_concurrent_executions" {
  default     = -1
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

variable "tags" {
  type    = "map"
}
