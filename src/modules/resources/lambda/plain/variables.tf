variable "name" {
  description = "Lambda name."
}

variable "role_arn" {
  description = "Role ARN."
}

variable "handler" {
  description = "The function entrypoint in your code."
}

variable "runtime" {
  default     = "nodejs10.x"
  description = "The identifier of the function's runtime."
}

variable "s3_bucket_name" {
  default     = null
  description = "Lambda source bucket (storage)"
}

variable "s3_bucket_path" {
  default     = null
  description = "Path to artifact (zipped lambda)"
}

variable "filepath" {
  default     = null
  description = "(Required) The path to the function's deployment package within the local filesystem."
}

variable "description" {
  default     = null
  description = "Lambda description."
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

  # default     = null

  default = {
    ENCODING = "utf-8"
  }
}

variable "logs_arn" {
  default     = null
  description = "Do not use this variable. It just for proper graph dependency."
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
