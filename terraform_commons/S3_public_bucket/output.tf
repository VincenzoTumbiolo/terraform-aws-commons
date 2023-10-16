# Output of module

output "s3" {
  description = "The S3 bucket"
  value       = aws_s3_bucket.this
}
