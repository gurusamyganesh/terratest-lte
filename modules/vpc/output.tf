output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "nacl_id" {
  value = aws_vpc.vpc.default_network_acl_id
}