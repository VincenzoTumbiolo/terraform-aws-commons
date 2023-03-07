resource "aws_sqs_queue" "this" {
  name = "${var.env}-${local.tags.project_prefix}-sqs"

  tags = local.tags
}
