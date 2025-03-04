variable "vpc_cidr" {
  description = "CIDR for the main VPC"
  default     = "10.0.0.0/16"
  type        = "string"
}

variable "rds_cidr" {
  description = "CIDR list for RDS private subnet"
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"
  ]
  type = "list"
}

variable "private_subnet_cidrs" {
  description = "CIDR list for EC2 instances private subnets"
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
  type = "list"
}

variable "public_subnet_cidrs" {
  description = "CIDR list for ELB public subnets"  
  default = [
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24"
  ]
  type = "list"
}

variable "azs" {}
