

resource "aws_api_gateway_gateway_response" "unauthorized_response" {
  rest_api_id   = var.rest_api_id
  status_code   = var.status_code
  response_type = var.response_type

  response_templates = {
    "application/json" = var.json_response_templates
  }
}
