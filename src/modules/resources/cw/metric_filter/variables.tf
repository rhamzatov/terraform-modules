variable "name" {
  description = "(Required) A name for the metric filter."
}

variable "pattern" {
  description = "(Required) A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
}

variable "log_group_name" {
  description = "(Required) The name of the log group to associate the metric filter with."
}

variable "transformation_namespace" {
  default     = "Albelli"
  description = "(Optional) The destination namespace of the CloudWatch metric."
}

variable "transformation_value" {
  default     = "1"
  description = "(Optional) What to publish to the metric. For example, if you're counting the occurrences of a particular term like 'Error', the value will be 1 for each occurrence. If you're counting the bytes transferred the published value will be the value in the log event."
}

variable "transformation_default_value" {
  default     = "0"
  description = "(Optional) The value to emit when a filter pattern does not match a log event."
}

