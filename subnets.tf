resource "aws_subnet" "dev-subnet-1" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = var.cidr_blocks[1]
  map_public_ip_on_launch = true
  availability_zone = var.az
  tags = {
    Name = var.env
  }
}



