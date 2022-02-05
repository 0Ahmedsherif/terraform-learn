resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}