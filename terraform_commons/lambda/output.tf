# Output of module

output "lambda_function" {
  description = "The lambda function."
  value       = aws_lambda_function.this
}
