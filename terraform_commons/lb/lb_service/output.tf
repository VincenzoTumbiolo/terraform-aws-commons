# Output of module

output "lb" {
  description = "aws load balancer"
  value       = aws_lb.this
}
