data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.private_app_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private-app-subnet-az1"
  }
}

resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.private_app_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private-app-subnet-az2"
  }
}

resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.private_data_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private-data-subnet-az1"
  }
}

resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = var.vpc_id
  cidr_block               = var.private_data_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private-data-subnet-az2"
  }
}
