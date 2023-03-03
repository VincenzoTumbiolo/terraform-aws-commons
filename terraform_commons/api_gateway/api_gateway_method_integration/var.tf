# Input of module

variable "rest_api_id" {
  description = "rest api id"
}
variable "resource_id" {
  description = "api gateway id"
}
variable "http_method" {
  description = "api gateway id"
}
variable "authorization" {
  description = "api gateway id"
}
variable "authorizer_id_check" {
  description = "api gateway id"
  default     = false
}
variable "request_parameters_check" {
  description = "api gateway id"
  default     = false
}
variable "authorizer_id" {
  description = "api gateway id"
  default     = null
}
variable "integration_http_method" {
  description = "api gateway id"
}
variable "type" {
  description = "api gateway id"
}
variable "uri" {
  description = "api gateway id"
}
variable "connection_id_check" {
  description = "api gateway id"
  default     = false
}
variable "connection_id" {
  description = "api gateway id"
  default     = null
}
