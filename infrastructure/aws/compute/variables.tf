variable "name" {
  
}

# Ubuntu Canonical 18.04 LTS
variable "aws_amis" {
  description = "Suggested AMIs for Web Servers depending on the region"
  default = {
      eu-central-1 = "ami-0cc0a36f626a4fdf5"
  }
}