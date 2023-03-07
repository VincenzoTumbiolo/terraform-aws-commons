# This file contain module of lambda functions.
# In modules, source path identify modules used. Check in files of source folder for more specifics.

module "log_lambda" {
  source                           = "./modules/lambda/logs"
  account_id                       = var.accountId
  env                              = var.env
  region                           = var.region
  project_prefix                   = local.tags.project_prefix
  lambda_log_processor_memory_size = var.lambda_log_processor_memory_size
  subnets                          = local.publicSubnetIds
  aws_security_group_ids           = [aws_security_group.lambda.id]
  environment_vars = {
    DB_HOST     = aws_rds_cluster.this.endpoint
    DB_NAME     = var.mysqlName
    DB_USERNAME = var.mysqlUsername
    DB_PASSWORD = var.mysqlPassword
    DB_PORT     = var.mysqlPort
  }

  tags = local.tags
}
