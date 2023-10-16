# Input of module

variable "vpc_id" {
  type        = string
  description = "vpc id for target group"
}
variable "lb_forward_target_group_name" {
  type        = string
  description = "name for target group"
}
variable "targhet_register" {
  type    = bool
  default = false
}
variable "lb_target_type" {
  type        = string
  description = "name for target group"
}
variable "lb_target_id" {
  type        = string
  description = "id of targhet for target group"
  default     = "null"
}
variable "lb_target_port" {
  type        = string
  description = "port of targhet for target group"
  default     = "null"
}
variable "protocol" {
  type        = string
  description = "name for target group"
}
variable "lb_forward_target_group_port" {
  type        = number
  description = "port for target group"
  default     = 80
}
variable "health_check_path" {
  default = "/health"
}
variable "health_check_port" {
  default = "traffic-port"
}
variable "health_check_protocol" {
  default = "HTTP"
}
variable "health_check_healthy_threshold" {
  default = 3
}
variable "health_check_unhealthy_threshold" {
  default = 3
}
variable "health_check_matcher" {
  default = "200"
}
variable "tags" {
  description = "A mapping of tags to assign to resources."
}
