# security group for EC2
resource "aws_security_group" "instance" {
  name        = "allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${var.vpc}"
  # allow only HTTP inbound traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
