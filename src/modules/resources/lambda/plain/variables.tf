variable "name" {
  description = "Lambda name"
}

variable "role_arn" {
  description = "Role ARN"
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
  type = "map"

  default = {
    ENCODING = "utf-8"
  }
}

variable "tags" {
  type    = "map"
  default = {}
}
