output "host_vpc" {
  value = "${aws_vpc.host_vpc.id}"
}

output "private_subnets" {
  value = "${aws_subnet.private_subnet.*.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "rds_subnet" {
  value = "${aws_subnet.private_rds_subnet.id}"
}

output "sqs_subnet" {
  value = "${aws_subnet.private_sqs_subnet.id}"
}
