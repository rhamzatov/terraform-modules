variable "alarm_name" {
  description = "(Required) The descriptive name for the alarm. This name must be unique within the user's AWS account"
}

variable "comparison_operator" {
  description = "(Required) The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
}

variable "evaluation_periods" {
  description = "(Required) The number of periods over which data is compared to the specified threshold."
}

variable "threshold" {
  description = "(Required) The value against which the specified statistic is compared."
}

variable "metric_name" {
  description = "(Required) The name for the alarm's associated metric."
}

variable "alarm_actions" {
  type        = "list"
  description = "(Required) The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
}

variable "datapoints_to_alarm" {
  default     = 1
  description = "(Optional) The number of datapoints that must be breaching to trigger the alarm."
}

variable "namespace" {
  default     = "Albelli"
  description = "(Optional) The namespace for the alarm's associated metric."
}

variable "period" {
  default     = 60
  description = "(Optional) The period in seconds over which the specified statistic is applied."
}

variable "statistic" {
  default     = "SampleCount"
  description = "(Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum."
}

variable "alarm_description" {
  default     = ""
  description = "(Optional) The description for the alarm."
}
