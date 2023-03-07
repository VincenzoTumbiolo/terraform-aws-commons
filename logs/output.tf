# Output of module

output "log_processor_lambda_function" {
  value = module.log_lambda.log_processor_lambda_function
}

output "rds_security_group" {
  value = aws_security_group.rds
}

output "rds_cluster" {
  value = aws_rds_cluster.this
}
