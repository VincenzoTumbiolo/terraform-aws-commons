# Input of module

variable "lb_name" {
  type        = string
  description = "name for alb"
}
variable "lb_type" {
  type        = string
  description = "type for alb"
}
variable "lb_security_group_id" {
  type        = string
  description = "security group id for alb"
  default     = null
}
variable "lb_subnet_ids" {
  type        = list(string)
  description = "list of subnets"
}
variable "log_bucket" {
  type        = string
  description = "name for alb"
}
variable "tags" {
  description = "A mapping of tags to assign to resources."
}
