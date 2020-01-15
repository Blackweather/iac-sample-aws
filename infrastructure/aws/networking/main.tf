resource "aws_vpc" "host_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "host_vpc"
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.host_vpc.id}"

  tags = {
    Name = "tf_igw"
  }
}

# Private subnets for launched EC2 instances
resource "aws_subnet" "private_subnet" {
  count                   = "${length(var.azs)}"
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

# Public subnet for LB access
resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.azs)}"
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${element(var.public_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Private subnet for RDS
resource "aws_subnet" "private_rds_subnet" {
  count                   = "${length(var.rds_cidr)}"
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${element(var.rds_cidr, count.index)}"
  map_public_ip_on_launch = false
  availability_zone       = "${element(var.azs, count.index)}"

  tags = {
    Name = "private-rds-subnet-${count.index}"
  }
}

# Private subnet for SQS
resource "aws_subnet" "private_sqs_subnet" {
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${var.sqs_cidr}"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
}

# main route table
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.host_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
  }

  tags = {
    Name = "public_rt"
  }
}

# associate route table with VPC
resource "aws_main_route_table_association" "public" {
  vpc_id         = "${aws_vpc.host_vpc.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

# associate public subnets with route table
resource "aws_route_table_association" "public" {
  count          = "${length(var.azs)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

# EIP for NAT Gateway
resource "aws_eip" "eip" {
  count      = "${length(var.azs)}"
  vpc        = true
  depends_on = ["aws_internet_gateway.tf_internet_gateway"]
}

# create NAT Gateways
resource "aws_nat_gateway" "nat_gw" {
  count         = "${length(var.azs)}"
  allocation_id = "${element(aws_eip.eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.tf_internet_gateway"]
}

# private route table for each private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.host_vpc.id}"
  count  = "${length(var.azs)}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat_gw.*.id, count.index)}"
  }

  tags = {
    Name = "private-subnet-rt-${count.index}"
  }
}
