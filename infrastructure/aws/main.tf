terraform {
  required_version = "~> 0.12.19"

  # not viable right now due to name uniqueness
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
  source                = "./compute"
  region                = "${var.region}"
  azs                   = "${var.azs}"
  vpc                   = "${module.networking.host_vpc}"
  private_subnets       = "${module.networking.private_subnets}"
}

module "networking" {
  source = "./networking"
  azs    = "${var.azs}"
}

module "database" {
  source = "./database"

}

module "queue" {
  source = "./queue"

}
