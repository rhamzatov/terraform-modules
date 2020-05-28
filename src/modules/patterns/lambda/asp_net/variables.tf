variable "name" {
  description = "Lambda and API name"
}

variable "handler" {
  description = "The function entrypoint in your code."
}

variable "s3_bucket_name" {
  default     = null
  description = "Lambda source bucket (storage)"
}

variable "s3_bucket_path" {
  default     = null
  description = "Path to artifact (zipped lambda)"
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
  default     = "512"
  description = "Amount of memory in MB your Lambda Function can use at runtime."
}

variable "timeout" {
  default     = "30"
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
  default     = "30"
}

variable "domain" {
}

variable "zone_id" {
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
