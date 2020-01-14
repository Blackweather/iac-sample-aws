resource "aws_security_group" "elb" {
  name        = "terraform_elb_sg"
  description = "Security group used for ELB"
  vpc_id      = "${var.vpc}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    # FIXME: this is vulnerable, change it to only the necessary IPs and ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound access to the Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name = "web-elb"

  subnets = [
    "${var.ec2_subnets[0]}",
    "${var.ec2_subnets[1]}",
    "${var.ec2_subnets[2]}",
    "${var.ec2_subnets[3]}",
    "${var.ec2_subnets[4]}",
  ]

  security_groups = ["${aws_security_group.elb.id}"]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
  ]

  health_check = [
    {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 3

      # can be later switched to /health endpoint
      target   = "HTTP:80/"
      interval = 30
    },
  ]
}

# set up sticky sessions for ELB
resource "aws_lb_cookie_stickiness_policy" "default" {
  name                     = "lbpolicy"
  load_balancer            = "${module.elb.this_elb_id}"
  lb_port                  = 80
  cookie_expiration_period = 600
}
