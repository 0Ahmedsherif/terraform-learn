provider "aws" {
    region = var.region
}

variable vpc_cidr_block {} 
variable private_subnet_cidr_blocks {} 
variable public_subnet_cidr_blocks {} 
variable region {} 


data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true # => one nat gw for the three private subnets
  enable_dns_hostnames = true

  tags = {
      "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  }

  public_subnet_tags = {
      "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
      "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
      "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
      "kubernetes.io/role/internal=elb" = 1
  } 
}