resource "aws_db_instance" "web_db" {
  name = "${var.db_name}"

  allocated_storage = "${var.storage}"
  engine            = "${var.engine}"
  engine_version    = "${lookup(var.engine_version, var.engine)}"
  instance_class    = "${var.instance_class}"

  username = "${var.username}"
  password = "${var.password}"

  db_subnet_group_name   = "${aws_db_subnet_group.web_db_subnet_group.id}"
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
}

resource "aws_db_subnet_group" "web_db_subnet_group" {
  description = "Group of subnets used for DB instance"
  name        = "web-db-subnet-group"
  subnet_ids  = "${var.rds_subnets}"
}

resource "aws_security_group" "db_sg" {
  name        = "web-db-sg"
  description = "Allow inbound traffic to DB endpoint"
  vpc_id      = "${var.vpc}"

  ingress {
    from_port = "${lookup(var.db_port, var.engine)}"
    to_port   = "${lookup(var.db_port, var.engine)}"
    protocol  = "TCP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-db-sg"
  }
}
