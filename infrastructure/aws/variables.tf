variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = "string"
}

variable "project_name" {
  default = "iac-aws-terraform"
  type    = "string"
}
