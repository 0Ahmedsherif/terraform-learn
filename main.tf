# Provider
provider "aws" {
    region = var.region
}

# Vpc
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
    source = "./modules/subnet"
    vpc_id = aws_vpc.myapp-vpc.id
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
    subnet_cidr_block = var.subnet_cidr_block
    env_prefix = var.env_prefix
    az = var.az
}

module "myapp-server" {
    source = "./modules/webserver"
    vpc_id =  aws_vpc.myapp-vpc.id
    my_ip = var.my_ip
    env_prefix = var.env_prefix
    image_name = var.image_name
    public_key_location = var.public_key_location
    instance_type = var.instance_type
    subnet_id = module.myapp-subnet.subnet.id
    az = var.az 
}