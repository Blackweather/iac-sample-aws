resource "aws_vpc" "host-vpc" {
  cidr_block = "${var.vpc_cidr}"
}

