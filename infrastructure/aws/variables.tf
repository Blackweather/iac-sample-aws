variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
  type        = "string"
}

variable "project_name" {
  default = "iac-aws-terraform"
  type    = "string"
}

variable vpc_cidr {
  description = "CIDR for the main VPC"
  default     = "10.0.0.0/16"
  type        = "string"
}

