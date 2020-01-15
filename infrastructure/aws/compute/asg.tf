resource "aws_launch_configuration" "web_asg_lc" {
  image_id        = "${lookup(var.aws_amis, var.region)}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.instance.id}"]
  user_data       = "${file("compute/userdata.sh")}"

  iam_instance_profile = "${aws_iam_instance_profile.CloudWatchAgentServerRole-instanceprofile.name}"

  lifecycle {
    # prevent timeout
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "web_asg" {
  name                 = "web-asg"
  launch_configuration = "${aws_launch_configuration.web_asg_lc.id}"

  vpc_zone_identifier = "${var.private_subnets}"
  target_group_arns   = ["${aws_alb_target_group.web_alb_tg.arn}"]

  desired_capacity = "${var.instance_count}"
  max_size         = "${var.max_instance_count}"
  min_size         = "${var.min_instance_count}"

  health_check_type = "ELB"
  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = true
  }

}
