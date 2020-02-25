variable "name" {
  description = "Lambda name"
}

variable "handler" {
  description = "The function entrypoint in your code."
}

variable "s3_bucket_name" {
  description = "Lambda source bucket (storage)"
}

variable "s3_bucket_path" {
  default     = ""
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
  default     = "30"
}

variable "max_concurrent_executions" {
  default     = -1
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

variable "schedule_expression" {
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
}

variable "tags" {
  type = map(string)
}

