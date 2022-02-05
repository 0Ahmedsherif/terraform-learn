resource "aws_subnet" "myapp-subnet-1" {
  vpc_id     = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone = var.az
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}