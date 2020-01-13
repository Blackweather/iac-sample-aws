module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name = "my-instances"
  instance_count = 2

  ami = "${lookup(var.aws_amis, var.region)}"

  user_data = "${file("userdata.sh")}"
  
}
