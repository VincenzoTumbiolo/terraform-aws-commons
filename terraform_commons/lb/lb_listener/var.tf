# Input of module

variable "aws_lb_arn" {
  type        = string
  description = "arn of alb"
}
variable "lb_forward_listener_port" {
  type        = string
  description = "port for listener from 1 to 65535"
}
variable "lb_forward_listener_protocol" {
  type        = string
  description = "protocol for listener"
}
variable "tags" {
  description = "A mapping of tags to assign to resources."
}
