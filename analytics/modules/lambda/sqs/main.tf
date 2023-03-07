//-------------------------------- message_processor MODE -----------------------------------------

data "aws_iam_policy_document" "message_processor" {
  statement {
    sid = "0"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:*"
    ]
  }
  statement {
    sid = "1"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "2"
    actions = [
      "lambda:CreateEventSourceMapping",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctions"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "3"
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role" "message_processor" {
  name               = "${var.env}-${local.tags.project_prefix}-lambda-role-message_processor"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }]
  }
  EOF
}

resource "aws_iam_role_policy" "message_processor-policy" {
  name   = "${var.env}-${local.tags.project_prefix}-lambda-invoke-function-message_processor-policy"
  role   = aws_iam_role.message_processor.id
  policy = data.aws_iam_policy_document.message_processor.json
}

module "message_processor" {
  source          = "git::https://github.com/VincenzoTumbiolo/utility.git//terraform_commons/lambda?ref=development"
  lambda_tags     = local.tags
  cloudwatch_tags = {}
  tags            = local.tags
  source_dir      = "${path.module}/message_processor"
  output_path     = "${path.module}/message_processor/dist/message_processor.zip"

  build_triggers = {
    requirements = base64sha256(file("${path.module}/message_processor/package-lock.json"))
    code = jsonencode({
      for fn in fileset("${path.module}/message_processor", "**") :
      fn => filesha256("${path.module}/message_processor/${fn}")
    })
  }

  build_command = "npm install && npm run build"
  iam_role_arn  = aws_iam_role.message_processor.arn
  function_name = "${var.env}-${local.tags.project_prefix}-message_processor"
  handler       = "dist/index.handler"
  runtime       = "nodejs16.x"
  memory_size   = var.lambda_message_processor_memory_size
  timeout       = 30
  log_retention = var.log-retention
  environment = {
    variables = var.environment_vars
  }
  vpc_config = {
    subnet_ids         = var.subnets
    security_group_ids = var.aws_security_group_ids
  }
  cloudwatch_alarm_tags = {}
  env                   = var.env
  project_prefix        = var.project_prefix
  account_id            = var.account_id
}
