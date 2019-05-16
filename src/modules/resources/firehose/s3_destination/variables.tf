variable "name" {}

variable "role_arn" {}

variable "bucket_arn" {}

variable "buffer_interval_in_seconds" {
  default = 300
}

variable "buffer_size_in_mb" {
  default = 5
}

variable "tags" {
  type = "map"
}
