resource "aws_vpc" "dev-vpc" {
  cidr_block = var.cidr_blocks[0]
  enable_dns_support = true
  tags = {
    Name = var.env
  }
}