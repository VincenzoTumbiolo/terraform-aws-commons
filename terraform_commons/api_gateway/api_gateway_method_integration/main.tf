
resource "aws_api_gateway_method" "method" {
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = var.http_method
  authorization = var.authorization
  authorizer_id = var.authorizer_id_check ? var.authorizer_id : null
  request_parameters = var.request_parameters_check ? {
    "method.request.path.proxy" = true
  } : null
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = var.integration_http_method
  type                    = var.type
  uri                     = var.uri
  connection_type         = var.connection_id_check ? "VPC_LINK" : null
  connection_id           = var.connection_id_check ? var.connection_id : null


  cache_key_parameters = var.request_parameters_check ? ["method.request.path.proxy"] : null

  timeout_milliseconds = var.request_parameters_check ? 29000 : null
  request_parameters = var.request_parameters_check ? {
    "integration.request.path.proxy" = "method.request.path.proxy"
  } : null
}
