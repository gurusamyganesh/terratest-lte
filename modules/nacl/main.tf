resource "aws_default_network_acl" "default_network_acl" {
  default_network_acl_id = var.default_nacl_id
  subnet_ids             = [var.public_subnetid, var.private_subnetid]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.project_name}-default-network-acl"
  }
}