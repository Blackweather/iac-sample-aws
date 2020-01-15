variable "storage" {
  description = "Storage size in GB"
  default     = "10"
}

variable "engine" {
  description = "Engine used for RDS"
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version"

  default = {
    postgres = "11.5"
  }
}

variable "db_port" {
  description = "Port used by database"

  default = {
    postgres = 5432
  }
}


variable "instance_class" {
  description = "Instance class used for DB"
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "Name of the database"
  default     = "webdb"
}

variable "username" {
  description = "Username used for DB"
  default = "pgres"
}

variable "password" {
  description = "Password, needs to be provided through environment variables"
  default = "testtest123" // for testing purposes
}

variable "vpc" {}

variable "rds_subnets" {
  
}
