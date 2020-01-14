terraform {
  required_version = "~> 0.12.19"

  # not viable for this task due to name uniqueness
  # backend "s3" {
  #     bucket = "company-terraform"
  #     key = "terraform.tfstate"
  #     region = "us-east-1"
  # }
}

provider "aws" {
  version = "~> 2.44.0"
  region  = "${var.region}"
}
module "compute" {
  source = "./compute"
  region = "${var.region}"
  vpc    = "${module.networking.host_vpc}"
  ec2_subnets = "${module.networking.ec2_subnets}"
}

module "networking" {
  source    = "./networking"
  vpc_cidr  = "${var.vpc_cidr}"
  rds_cidr  = "${var.rds_cidr}"
  sqs_cidr  = "${var.sqs_cidr}"
  ec2_cidrs = "${var.ec2_cidrs}"
}

module "database" {
  source = "./database"

}

module "queue" {
  source = "./queue"

}
