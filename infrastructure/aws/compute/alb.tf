resource "aws_security_group" "alb" {
  name        = "web-alb-sg"
  description = "Security group used for ALB"
  vpc_id      = "${var.vpc}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound access to the Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-alb-sg"
  }
}

resource "aws_alb" "web_alb" {
  name            = "web-alb"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = "${var.private_subnets}"

  tags = {
    Name = "web-alb"
  }
}

resource "aws_alb_target_group" "web_alb_tg" {
  name     = "web-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc}"
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_alb_listener" "web_alb_listener" {
  load_balancer_arn = "${aws_alb.web_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.web_alb_tg.arn}"
    type             = "forward"
  }
}
