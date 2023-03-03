# Output of module

output "task_definition" {
  description = "aws task definition"
  value       = aws_ecs_task_definition.this
}

output "log_group" {
  value = aws_cloudwatch_log_group.service
}
