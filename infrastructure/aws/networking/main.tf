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

data "aws_availability_zones" "available" {}
# Private subnets for launched EC2 instances
resource "aws_subnet" "private_ec2_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${var.ec2_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
}

resource "aws_subnet" "public_elb_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${var.elb_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
}

# Private subnet for RDS
resource "aws_subnet" "private_rds_subnet" {
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${var.rds_cidr}"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
}

# Private subnet for SQS
resource "aws_subnet" "private_sqs_subnet" {
  vpc_id                  = "${aws_vpc.host_vpc.id}"
  cidr_block              = "${var.sqs_cidr}"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
}


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

resource "aws_route_table_association" "public_rt_assoc_elb" {
  count          = "${length(aws_subnet.public_elb_subnet)}"
  subnet_id      = "${aws_subnet.public_elb_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.public_rt.id}"
}



resource "aws_default_route_table" "private_rt" {
  default_route_table_id = "${aws_vpc.host_vpc.default_route_table_id}"

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_rt_assoc_ec2" {
  count          = "${length(aws_subnet.private_ec2_subnet)}"
  subnet_id      = "${aws_subnet.private_ec2_subnet.*.id[count.index]}"
  route_table_id = "${aws_default_route_table.private_rt.id}"
}
