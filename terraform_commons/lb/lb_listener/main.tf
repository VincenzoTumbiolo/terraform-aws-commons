resource "aws_lb_listener" "this" {
  load_balancer_arn = var.aws_lb_arn
  port              = var.lb_forward_listener_port
  protocol          = var.lb_forward_listener_protocol
  certificate_arn   = var.lb_forward_listener_protocol == "HTTPS" ? var.lb_certificate_arn : null


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "FORWARD ERROR"
      status_code  = "400"
    }
  }

  tags = var.tags
}
