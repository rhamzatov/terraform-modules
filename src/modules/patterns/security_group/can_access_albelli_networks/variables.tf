variable "name" {}

variable "vpc_id" {}

variable "extra_ranges" {
  default = []
  type    = list(string)
}

variable "tags" {
  type = map(string)
}
