resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = true
  load_balancer_type = var.lb_type
  security_groups    = var.lb_type == "application" ? [var.lb_security_group_id] : null
  subnets            = var.lb_subnet_ids

  enable_deletion_protection = false

  access_logs {
    bucket  = var.log_bucket
    prefix  = var.lb_name
    enabled = true
  }

  tags = var.tags
}
