#---------------------------------------------------------------------------------------------------
# Lambda functions
#---------------------------------------------------------------------------------------------------

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.source.output_path
  role             = var.iam_role_arn
  source_code_hash = data.archive_file.source.output_base64sha256

  runtime                        = var.runtime
  handler                        = var.handler
  description                    = var.description
  function_name                  = var.function_name
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  layers                         = var.layers
  timeout                        = var.timeout
  publish                        = var.publish
  architectures                  = [var.architecture]

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config == null ? [] : [var.dead_letter_config]
    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }

  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }

  dynamic "tracing_config" {
    for_each = var.tracing_config == null ? [] : [var.tracing_config]
    content {
      mode = tracing_config.value.mode
    }
  }
  tags = merge(var.tags, var.lambda_tags, { "Name" = var.function_name })

  lifecycle {
    ignore_changes = [filename]
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  depends_on = [
  aws_cloudwatch_log_group.log-group, data.archive_file.source]
}

resource "aws_cloudwatch_log_group" "log-group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention
  tags              = merge(var.tags, var.cloudwatch_tags, { "Name" = "/aws/lambda/${var.function_name}" })
}

resource "aws_cloudwatch_metric_alarm" "lambda-throttles" {
  alarm_name          = "${var.project_prefix}alarm-lambda-${var.function_name}-throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors ${var.function_name}"
  tags                = merge(var.tags, var.cloudwatch_alarm_tags, { "Name" = "${var.project_prefix}alarm-lambda-${var.function_name}-throttles" })
  dimensions = {
    FunctionName = var.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda-errors" {
  alarm_name          = "${var.project_prefix}alarm-lambda-${var.function_name}-throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "This metric monitors ${var.function_name}"
  tags                = merge(var.tags, var.cloudwatch_tags, { "Name" = "${var.project_prefix}alarm-lambda-${var.function_name}-throttles" })
  dimensions = {
    FunctionName = var.function_name
  }
}
