# This file contain module of lambda functions.
# In modules, source path identify modules used. Check in files of source folder for more specifics.

module "sqs_lambda" {
  source                               = "./modules/lambda/sqs"
  account_id                           = var.accountId
  tags                                 = local.tags
  env                                  = var.env
  region                               = var.region
  lambda_message_processor_memory_size = var.lambda_message_processor_memory_size
  project_prefix                       = local.tags.project_prefix
  subnets                              = local.publicSubnetIds
  aws_security_group_ids               = [aws_security_group.lambda.id]
  environment_vars = {
    DOCUMENT_DB_URI = "mongodb+srv://${var.dbUser}:${var.dbPassword}@${local.endpoint_db_uri}/${var.databaseName}?retryWrites=true&w=majority"
  }
}

resource "aws_lambda_event_source_mapping" "this" {
  event_source_arn = aws_sqs_queue.this.arn
  enabled          = true
  function_name    = module.sqs_lambda.message_processor_lambda_function.arn
  batch_size       = 1
}
