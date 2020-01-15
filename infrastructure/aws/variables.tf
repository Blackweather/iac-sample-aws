variable "region" {
  description = "AWS region - US East Virginia"
  default     = "us-east-1"
  type        = "string"
}

variable "azs" {
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
