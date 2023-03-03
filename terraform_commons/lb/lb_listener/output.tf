# Output of module

output "listener" {
  description = "aws listener"
  value       = aws_lb_listener.this
}
