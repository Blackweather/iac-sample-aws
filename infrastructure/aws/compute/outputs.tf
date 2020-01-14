output "instance_ids" {
  value = "${join(", ", aws_instance.web.*.id)}"
}

output "instance_ips" {
  value = "${aws_instance.web.*.public_ip}"
}

output "elb_dns_name" {
  value = "${aws_elb.web.dns_name}"
}
