# Output of module

output "task_definition" {
  description = "aws task definition"
  value       = aws_ecs_task_definition.this
}
output "container_name" {
  description = "aws container name of task"
  value       = "${var.ecs_name}-container"
}
output "ddog_container_name" {
  description = "aws container name of task"
  value       = "${var.ecs_name}-container"
}

output "log_group" {
  value = aws_cloudwatch_log_group.service
}
