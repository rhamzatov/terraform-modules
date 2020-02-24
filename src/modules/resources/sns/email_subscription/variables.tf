variable "sns_topic_arn" {
  description = "(Required) SNS topic to subscribe."
}

variable "emails" {
  type        = list(string)
  description = "(Required) Emails to notify."
}

variable "region" {
  default     = "eu-west-1"
  description = "(Optional) The region to use."
}

