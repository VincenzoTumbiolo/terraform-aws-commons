resource "aws_network_acl" "this" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id, aws_subnet.isolated_subnet1.id, aws_subnet.isolated_subnet2.id]

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(local.tags, { Name = "${local.tags.initials}${var.region}/acl" })
}
