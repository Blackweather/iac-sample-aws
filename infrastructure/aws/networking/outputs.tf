output "host_vpc" {
  value = "${aws_vpc.host_vpc.id}"
}

output "ec2_subnets" {
  value = "${aws_subnet.public_ec2_subnet.*.id}"
}

output "rds_subnet" {
  value = "${aws_subnet.private_rds_subnet.id}"
}

output "sqs_subnet" {
  value = "${aws_subnet.private_sqs_subnet.id}"
}

output "ec2_subnet_ips" {
  value = "${aws_subnet.public_ec2_subnet.*.cidr_block}"
}
