resource "aws_instance" "web" {
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  subnet_id = "${element(var.ec2_subnets, count.index)}"

  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"

  ami = "${lookup(var.aws_amis, var.region)}"

  user_data = "${file("compute/userdata.sh")}"

  # name the instance depending on the number in ASG
  tags = {
    Name = "${format("web-%03d", count.index + 1)}"
  }
}

# security group for EC2
resource "aws_security_group" "instance" {
  name        = "allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${var.vpc}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
