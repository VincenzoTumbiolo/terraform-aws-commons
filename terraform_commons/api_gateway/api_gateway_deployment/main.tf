
resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = var.rest_api_id
  triggers = {
    redeployment = sha1(jsonencode(var.redeploy_triggher))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage_name
  tags          = var.tags
}

resource "aws_api_gateway_method_settings" "method_settings" {
  rest_api_id = var.rest_api_id
  stage_name  = aws_api_gateway_stage.stage.stage_name
  method_path = var.method_path
  settings {
    logging_level      = var.logging_level
    data_trace_enabled = true
    metrics_enabled    = true
  }
}
