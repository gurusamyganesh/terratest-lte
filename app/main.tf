provider "aws" {
  region = var.region
  # profile = "terraform-user1" 
  # profile = "terraform-user1" 
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

locals {
  environment = terraform.workspace
}

module "vpc" {
  vpc-name = "vpc-${local.environment}"
  source                            = "../modules/vpc"
  region                            = var.region
  project_name                      = var.project_name
  vpc_cidr                          = var.vpc_cidr
}

module "igw" {
  source = "../modules/IGW"
  vpc_id = module.vpc.vpc_id
  project_name = var.project_name
}

module "routetable" {
  source = "../modules/routetable"
  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.igw.internet_gateway_id
}

module "subnet" {
  source = "../modules/pvt-subnet"
  vpc_id = module.vpc.vpc_id
  project_name = var.project_name
  internet_gateway_id = module.igw.internet_gateway_id
  route_table_id = module.routetable.route_table_id
  private_app_subnet_az1_cidr       = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr       = var.private_app_subnet_az2_cidr 
  private_data_subnet_az1_cidr      = var.private_data_subnet_az1_cidr 
  private_data_subnet_az2_cidr      = var.private_data_subnet_az2_cidr 
}

data "aws_availability_zones" "available_zones" {}

module "public-subnet1" {
  source = "../modules/pub-subnet"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr_az1
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  public_subnet_name = "${var.public_subnet_name}-1"
}

module "public-subnet2" {
  source = "../modules/pub-subnet"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr_az2
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  public_subnet_name = "${var.public_subnet_name}-2"
}

module "rt-assocation-az1" {

  source = "../modules/rtassociations"
  route_table_id = module.routetable.route_table_id
  subnet_id = module.public-subnet1.public_subnet_id
}

module "rt-assocation-az2" {

  source = "../modules/rtassociations"
  route_table_id = module.routetable.route_table_id
  subnet_id = module.public-subnet2.public_subnet_id
}