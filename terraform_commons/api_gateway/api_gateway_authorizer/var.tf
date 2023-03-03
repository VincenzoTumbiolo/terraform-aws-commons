# Input of module

variable "name" {
  description = "name of authorizer"
}

variable "rest_api_id" {
  description = "rest api id"
}

variable "lambda_arn" {
  description = "arn of auth lambda"
}

variable "ttl" {
  description = "time to live of authorizer policy"
  default     = 300
}

variable "function_name" {
  description = "name of auth lambda"
}

variable "source_arn" {
  description = "invokation arn of auth lambda"
}

variable "invocation_role_name" {
  description = "invocation role name"
}

variable "invocation_policy_name" {
  description = "invocation policy name"
}

variable "rest_api_execution_arn" {
  description = "rest api execution arn"
}
variable "env" {
  description = "environment"
}
variable "account_id" {
  description = "aws account id"
}
variable "identity_source" {
  default = "Authorization"
}

variable "tags" {
  description = "Tags to apply on resources"
}
