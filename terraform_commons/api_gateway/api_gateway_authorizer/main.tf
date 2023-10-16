

resource "aws_iam_role" "invocation_role" {
  name = var.invocation_role_name
  path = "/"
  tags = var.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "invocation_policy" {
  statement {
    sid = "0"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "${var.lambda_arn}"
    ]
  }
}

resource "aws_iam_role_policy" "auth_invocation_policy" {
  name   = var.invocation_policy_name
  role   = aws_iam_role.invocation_role.id
  policy = data.aws_iam_policy_document.invocation_policy.json
}

resource "aws_api_gateway_authorizer" "auth" {
  name                             = var.name
  rest_api_id                      = var.rest_api_id
  authorizer_uri                   = var.source_arn
  authorizer_credentials           = aws_iam_role.invocation_role.arn
  authorizer_result_ttl_in_seconds = var.ttl
  identity_source                  = "method.request.header.${var.identity_source}"
}
