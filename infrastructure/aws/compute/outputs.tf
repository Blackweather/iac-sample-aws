output "server_id" {
  value = "${join(", ", aws_instance.web.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.web.*.public_ip)}"
}

output "instance_id" {
  value = "${aws_instance.web.id}"
}