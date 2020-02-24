variable "name" {
  description = "The name of the log group. If omitted, Terraform will assign a random, unique name."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "retention_in_days" {
  default     = 90
  description = "(Optional) Specifies the number of days you want to retain log events in the specified log group."
}

