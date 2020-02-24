variable "name" {
  description = "(Required) Name used for entities like lambda, IAM role etc. For consistency with suffixes, use CamelCase."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "handler" {
  description = "(Required) The function entrypoint in your code."
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

variable "emails" {
  default     = []
  type        = list(string)
  description = "(Optional) Emails for notification in case of errors"
}

variable "runtime" {
  default     = "dotnetcore2.1"
  description = "(Optional) The identifier of the function's runtime."
}

variable "description" {
  default     = null
  description = "(Optional) Lambda description"
}

variable "memory_size" {
  default     = "512"
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime."
}

variable "timeout" {
  default     = "30"
  description = "(Optional) The amount of time your Lambda Function has to run in seconds."
}

variable "variables" {
  type = map(string)

  default = {
    ENCODING = "utf-8"
  }
}

variable "comparison_operator" {
  default     = "GreaterThanOrEqualToThreshold"
  description = "(Optional) The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
}

variable "pattern" {
  default     = "ERROR"
  description = "(Optional) A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
}

variable "alert_period" {
  default     = "3600"
  description = "(Optional) The period in seconds over which the specified statistic is applied."
}

variable "evaluation_periods" {
  default     = "1"
  description = "(Optional) The number of periods over which data is compared to the specified threshold."
}

variable "statistic" {
  default     = "Sum"
  description = "(Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum."
}

variable "threshold" {
  default     = "1"
  description = "(Optional) The value against which the specified statistic is compared."
}

variable "log_retention_days" {
  default     = "30"
  description = "(Optional) Cloudwatch logs retention."
}

variable "max_concurrent_executions" {
  default     = "-1"
  description = "(Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

