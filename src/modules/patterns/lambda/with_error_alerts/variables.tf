variable "app_name" {
  description = "(Required) Name used for entities like lambda, IAM role etc. For consistency with suffixes, use CamelCase."
}

variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource."
}

variable "handler" {
  description = "(Required) The function entrypoint in your code."
}

variable "s3_bucket_name" {
  description = "(Required) Lambda source bucket (storage)"
}

variable "emails" {
  type        = "list"
  description = "(Required) Emails for notification in case of errors"
}

variable "s3_bucket_path" {
  default     = ""
  description = "(Optional) Path to artifact (zipped lambda)"
}

variable "runtime" {
  default     = "dotnetcore2.1"
  description = "(Optional) The identifier of the function's runtime."
}

variable "description" {
  default     = ""
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
  type = "map"

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

variable "period" {
  default     = "3600"
  description = "(Optional) The period in seconds over which the specified statistic is applied."
}

variable "evaluation_periods" {
  default     = "1"
  description = "(Optional) The number of periods over which data is compared to the specified threshold."
}

variable "statistic" {
  default     = "SampleCount"
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
