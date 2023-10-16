# Output of module

output "lambda_function" {
  description = "The lambda function."
  value       = aws_lambda_function.this
}

output "archive_file" {
  description = "ArchiveFile of function to deploy"
  value       = data.archive_file.source
}
