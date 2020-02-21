variable "name" {
}

variable "destination_bucket_name" {
}

variable "buffer_interval_in_seconds" {
  default = 60
}

variable "buffer_size_in_mb" {
  default = 1
}

variable "sumo_aws_account" {
  default = "926226587429"
}

variable "sumo_external_id" {
  default = "eu:0000000000218053"
}

variable "sumo_notification_endpoint" {
  default = ""
}

variable "tags" {
  type = map(string)
}

