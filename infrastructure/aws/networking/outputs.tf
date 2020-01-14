output "host_vpc" {
  value = "${aws_vpc.host_vpc.id}"
}

output "ec2_subnets" {
  value = "${aws_subnet.private_ec2_subnet.*.id}"
}

output "elb_subnets" {
  value = "${aws_subnet.public_elb_subnet.*.id}"
}

output "rds_subnet" {
  value = "${aws_subnet.private_rds_subnet.id}"
}

output "sqs_subnet" {
  value = "${aws_subnet.private_sqs_subnet.id}"
}
