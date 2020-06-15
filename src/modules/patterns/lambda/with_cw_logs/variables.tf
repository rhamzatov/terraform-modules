variable "name" {
  description = "Lambda name"
}

variable "handler" {
  description = "The function entrypoint in your code."
}

variable "filepath" {
  default     = null
  description = "(Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
}

variable "s3_bucket_name" {
  default     = null
  description = "(Optional) The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function."
}

variable "s3_bucket_path" {
  default     = null
  description = "(Optional) The S3 key of an object containing the function's deployment package. Conflicts with filename."
}

variable "runtime" {
  default     = "dotnetcore3.1"
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
  type = map(string)

  default = {
    ENCODING = "utf-8"
  }
}

variable "log_retention_days" {
  type        = string
  description = "Cloudwatch logs retention"
  default     = "7"
}

variable "max_concurrent_executions" {
  default     = -1
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

variable "tags" {
  type = map(string)
}

variable "vpc_config" {
  description = "VPC Config for the Lambda function"
  type        = map
  default     = null
}
