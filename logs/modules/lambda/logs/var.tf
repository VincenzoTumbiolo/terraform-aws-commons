# Input of module

variable "account_id" {
  type    = string
  default = ""
}

variable "log-retention" {
  default     = 14
  description = "default cloudwatch log retention"
}

variable "env" {
  default = "dev"
}

variable "region" {
  type = string
}

variable "project_prefix" {
  type = string
}

variable "subnets" {
  type        = list(string)
  description = "A mapping of methods in api gateway to assign to variables"
}

variable "aws_security_group_ids" {
  type        = list(string)
  description = "A mapping of resources in api gateway to assign to variables"
}

variable "environment_vars" {
  type    = map(any)
  default = {}
}

variable "lambda_log_processor_memory_size" {
  type = number
}

variable "tags" {
  description = "Tags to apply on resources"
}

locals {
  tags = merge(var.tags)
}
