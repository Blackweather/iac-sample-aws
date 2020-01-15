variable "visibility_timeout_seconds" {
  description = "Timeout in seconds of visibility of the message"
  default     = 30
}

variable "delay_seconds" {
  description = "Delay in displaying message"
  default     = "0"
}

variable "max_message_size" {
  default = "262144" // 256KB
}

variable "message_retention_seconds" {
  default = "86400" // 1 day
}

variable "max_receive_count" {
  default = "5"
}
