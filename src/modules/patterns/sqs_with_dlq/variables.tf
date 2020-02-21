variable "name" {
}

variable "visibility_timeout_seconds" {
  default     = 30
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)."
}

variable "message_retention_seconds" {
  default     = 1209600
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). "
}

variable "max_message_size" {
  default     = 262144
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)."
}

variable "delay_seconds" {
  default     = 0
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
}

variable "receive_wait_time_seconds" {
  default     = 0
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). Zero means that the call will return immediately."
}

variable "max_receive_count" {
  default     = 3
  description = "The JSON policy to set up the Dead Letter Queue"
}

variable "policy" {
  default     = ""
  description = "The JSON policy for the SQS queue"
}

variable "tags" {
  type = map(string)
}

