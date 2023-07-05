resource "aws_vpc" "vpc" {
  # name = var.vpc-name
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  tags      = {
    Name    = var.vpc-name
  }
}