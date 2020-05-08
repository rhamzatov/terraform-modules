variable "name" {}

variable "vpc_id" {}

variable "ingress_ip_ranges" {
  default = ["0.0.0.0/0"]
}

variable "egress_ip_ranges" {
  default = ["0.0.0.0/0"]
}

variable "tags" {
  type = map(string)
}
