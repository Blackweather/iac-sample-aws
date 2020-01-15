variable "region" {
  description = "AWS region - US East Virginia"
  default     = "us-east-1"
  type        = "string"
}

variable "azs" {
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "project_name" {
  default = "iac-aws-terraform"
  type    = "string"
}

variable "rds_az" {
  description = "AZ used for RDS"
  default = "us-east-1a"
}

variable "sqs_az" {
  description = "AZ used for SQS"
  default = "us-east-1a"
}
