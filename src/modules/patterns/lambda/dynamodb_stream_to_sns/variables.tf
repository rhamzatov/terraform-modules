variable "name" {
  description = "(Required) Name used for entities like lambda, IAM role etc. For consistency with suffixes, use CamelCase."
}

variable "event_source_arn" {
  description = "(Required) The event source ARN - can either be a Kinesis or DynamoDB stream."
}

variable "topic_arn" {
  description = "(Required) SNS topic you want to publish to."
}

variable "tags" {
  type        = map(string)
  description = "(Required) A mapping of tags to assign to the resource."
}

variable "emails" {
  default     = []
  type        = list(string)
  description = "(Optional) Emails for notification in case of errors"
}

variable "batch_size" {
  default     = 1
  description = "(Optional) The largest number of records that Lambda will retrieve from your event source at the time of invocation."
}

variable "description" {
  default     = null
  description = "(Optional) Lambda description"
}

variable "alert_period" {
  default     = "3600"
  description = "(Optional) The period in seconds over which the specified statistic is applied."
}

variable "dlq_suffix" {
  default     = "ERROR"
  description = "(Optional) DLQ name has structure: {name}_{dlq_suffix}"
}

variable "max_concurrent_executions" {
  default     = "-1"
  description = "(Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

variable "parallelization_factor" {
  default     = 1
  description = "(Optional) The number of batches to process from each shard concurrently. Minimum and default of 1, maximum of 10."
}

variable "maximum_retry_attempts" {
  default     = 10000
  description = "(Optional) The maximum number of times to retry when the function returns an error. Minimum of 0, maximum and default of 10000."
}

variable "bisect_batch_on_function_error" {
  default     = false
  description = "(Optional) If the function returns an error, split the batch in two and retry. Defaults to false."
}
