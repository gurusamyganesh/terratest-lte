provider "aws" {
  region = var.region
  # profile = "terraform-user" 
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}