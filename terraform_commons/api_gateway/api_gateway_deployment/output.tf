# Output of module

output "this" {
  value = aws_api_gateway_deployment.deploy
}
output "stage" {
  value = aws_api_gateway_stage.stage
}
