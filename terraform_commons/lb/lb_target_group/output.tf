# Output of module

output "target_group" {
  description = "aws target group"
  value       = aws_lb_target_group.this
}
