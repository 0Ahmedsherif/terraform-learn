# Subnet
resource "aws_subnet" "myapp-subnet-1" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone = var.az
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

# Route table
# using default route table (main), so that we don't need to make subnet association
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }

  tags = {
    Name = "${var.env_prefix}-main-rtb"
  }
}

# IGW
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}