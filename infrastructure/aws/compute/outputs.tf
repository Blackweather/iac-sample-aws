output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = "${module.web_asg.this_launch_configuration_id}"
}

output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = "${module.web_asg.this_autoscaling_group_id}"
}

output "this_elb_dns_name" {
  description = "DNS name of the ELB"
  value       = "${module.elb.this_elb_dns_name}"
}
