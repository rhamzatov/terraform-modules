variable "name" {
  description = "(Required) Name used for entities like lambda, IAM role etc. For consistency with suffixes, use CamelCase."
}

variable "event_source_arn" {
  description = "(Required) The event source ARN - can either be a Kinesis or DynamoDB stream."
}

variable "topic_arn" {
  description = "(Required) SNS topic you want to publish to."
}

variable "subject" {
  default     = "Dynamo stream event"
  description = "(Optional) SNS topic subject."
}

variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource."
}

variable "emails" {
  type        = "list"
  description = "(Required) Emails for notification in case of errors"
}

variable "batch_size" {
  default     = 1
  description = "(Optional) The largest number of records that Lambda will retrieve from your event source at the time of invocation."
}

variable "description" {
  default     = ""
  description = "(Optional) Lambda description"
}

variable "alert_period" {
  default     = "3600"
  description = "(Optional) The period in seconds over which the specified statistic is applied."
}
