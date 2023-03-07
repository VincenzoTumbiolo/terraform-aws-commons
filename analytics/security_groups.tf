# vpc created from aws console and referenced hear
data "aws_vpc" "this" {
  id = var.vpcId
}

# aws security group for all lambdas
resource "aws_security_group" "lambda" {
  name   = "${var.env}-${local.tags.project_prefix}-sg-lambda"
  vpc_id = var.vpcId

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.tags, { Name = "${var.env}-${local.tags.project_prefix}-sg-lambda" })
}

# aws security group for Auditing DB
resource "aws_security_group" "atlasdb" {
  name   = "${var.env}-${local.tags.project_prefix}-sg-atlasdb"
  vpc_id = var.vpcId

  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = [aws_security_group.lambda.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.tags, { Name = "${var.env}-${local.tags.project_prefix}-sg-atlasdb" })
}
