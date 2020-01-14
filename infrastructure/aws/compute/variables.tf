# Ubuntu Canonical 18.04 LTS
variable "aws_amis" {
  description = "Suggested AMIs for Web Servers depending on the region"
  default = {
      us-east-1 = "ami-04b9e92b5572fa0d1"
  }
}

variable "instance_count" {
  description = "Number of EC2 instances being created initially"
  default = 3
}

variable "min_instance_count" {
  description = "Minimum number of EC2 instances in the Auto Scaling group"
  default = 1
}

variable "max_instance_count" {
  description = "Maximum number of EC2 instances in the Auto Scaling group"
  default = 6
}

variable "instance_type" {
  description = "Suggested EC2 instance type"
  default = "t2.micro"
}

variable "region" {}

variable "azs" {}

variable "vpc" {}

variable "private_subnets" {
  type = "list"
}

