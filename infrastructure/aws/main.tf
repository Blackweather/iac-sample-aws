terraform {
    required_version = "~> 0.12.19"

    # not viable for this task due to name uniqueness
    # backend "s3" {
    #     bucket = "company-terraform"
    #     key = "terraform.tfstate"
    #     region = "eu-central-1"
    # }
}

provider "aws" {
  version = "~> 2.44.0"
  region = "${var.region}"
}
 module "compute" {
   source = "./compute"
   project_name = "${var.project_name}"
 }

 module "networking" {
   source = "./networking"

 }

 module "database" {
   source = "./database"

 }

 module "queue" {
   source = "./queue"
   
 }