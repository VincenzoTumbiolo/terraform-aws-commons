resource "aws_api_gateway_resource" "resource" {
  rest_api_id = var.api_gateway_rest_api_id
  parent_id   = var.api_gateway_root_resource_id
  path_part   = var.path_part
}

module "cors" {
  source      = "../api_gateway_cors"
  rest_api_id = var.api_gateway_rest_api_id
  resource_id = aws_api_gateway_resource.resource.id
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = var.aws_iam_role_cloudwatch_arn
}
