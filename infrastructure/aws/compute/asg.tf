#data "aws_availability_zones" "all" {}

# resource needed to use Auto Scaling
resource "aws_launch_configuration" "web_launch_conf" {
  image_id = "${lookup(var.aws_amis, var.region)}"
  instance_type = "${var.instance_type}"

  security_groups = ["${aws_security_group.instance.id}"]

  user_data = "${file("compute/userdata.sh")}"

  # help reduce downtime
  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  launch_configuration = "${aws_launch_configuration.web_launch_conf.id}"
  #availability_zones = ["${data.aws_availability_zones.all.names}"]
  availability_zones = ["us-east-1a"]

  min_size = "${var.min_instance_count}"
  max_size = "${var.max_instance_count}"

  load_balancers = ["${aws_elb.web.name}"]
  health_check_type = "ELB"
  tag {
      key = "Name"
      value = "web-asg"
      propagate_at_launch = true
  }
}
