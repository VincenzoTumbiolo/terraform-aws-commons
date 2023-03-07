# Input of module
variable "tags" {
  description = "Tags to apply on resources"
}


variable "log-retention" {
  default     = 14
  description = "default cloudwatch log retention"
}

variable "account_id" {
  type    = string
  default = ""
}

variable "region" {
  type = string
}

variable "env" {
  default = "dev"
}

variable "project_prefix" {
  type = string
}

variable "resource" {
  type    = string
  default = ""
}


variable "api_id" {
  type    = string
  default = ""
}

variable "subnets" {
  type        = list(string)
  description = "A mapping of methods in api gateway to assign to variables"
}

variable "aws_security_group_ids" {
  type        = list(string)
  description = "A mapping of resources in api gateway to assign to variables"
}


variable "lambda_message_processor_memory_size" {
  type = number
}

locals {
  tags = merge(var.tags)
}

variable "environment_vars" {
  type    = map(any)
  default = {}
}
