module "web_asg" {
  source  = "terraform-aws-modules/autoscaling/aws//examples/asg_elb"
  version = "2.5.1"

  name = "web-asg-with-elb"

  # Launch configuration
  lc_name = "web_launch_conf"

  image_id = "${lookup(var.aws_amis, var.region)}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.instance.id}"]

  load_balancers = ["${module.elb.this_elb_id}"]

  # Auto scaling group
  asg_name = "web-asg"
  #vpc_zone_identifier = "" //??
  health_check_type = "EC2"
  
  min_size = "${var.min_instance_count}"
  max_size ="${var.max_instance_count}"
  desired_capacity = "${var.instance_count}"
  wait_for_capacity_timeout = 0
  
}
