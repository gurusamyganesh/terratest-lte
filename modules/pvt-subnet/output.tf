output "project_name" {
  value = var.project_name
}

# output "public_subnet_az1_id" {
#   value = aws_subnet.public_subnet_az1.id
# }

# output "public_subnet_az2_id" {
#   value = aws_subnet.public_subnet_az2.id
# }

output "private_subnet_id" {
  value = aws_subnet.private_app_subnet_az1.id
}
