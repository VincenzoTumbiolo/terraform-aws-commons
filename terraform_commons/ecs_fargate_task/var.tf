# Input of module

variable "ecs_name" {
  type        = string
  description = "name for ecs"
}
variable "ecr_repository_url" {
  type        = string
  description = "ecr repository url for definition of container"
}
variable "task_containerPort" {
  type        = number
  description = "port for definition of container"
}
variable "task_hostPort" {
  type        = number
  description = "host port for definition of container"
}
variable "task_memory" {
  type        = number
  description = "memory required for container"
}
variable "task_cpu" {
  type        = number
  description = "cpu required for container"
}
variable "account_id" {
  type        = string
  description = "account id to of aws console"
}
variable "region" {
  type        = string
  description = "region for apply"
}
variable "tags" {
  description = "A mapping of tags to assign to resources."
}
variable "environments" {
  type        = list(any)
  description = "array of environments for task"
  default     = []
}
variable "ddog_enable" {
  type        = bool
  default     = false
  description = "true for activate datadog"
}
variable "ddog_environments" {
  type        = list(any)
  description = "array of datadog environments for task"
  default     = []
}
variable "ddog_image" {
  type        = string
  description = "datadog container image"
  default     = "datadog/agent:latest"
}
