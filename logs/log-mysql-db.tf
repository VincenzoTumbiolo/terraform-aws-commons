# Dedicated subnet group for MySql db cluster
resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-${local.tags.project_prefix}-db-subnet-group"
  subnet_ids = local.isolatedSubnetIds

  tags = local.tags
}

# MySql db cluster
resource "aws_rds_cluster" "this" {
  cluster_identifier              = "${var.env}-${local.tags.project-prefix}-db"
  engine                          = var.mysqlEngine
  allow_major_version_upgrade     = true
  engine_version                  = var.mysqlEngineVersion
  database_name                   = var.mysqlName
  master_username                 = var.mysqlUsername
  master_password                 = var.mysqlPassword
  port                            = var.mysqlPort
  backup_retention_period         = var.mysqlBackupRetention
  preferred_backup_window         = var.mysqlPreferredBackupTime
  skip_final_snapshot             = var.mysqlSkipFinalSnapshot
  db_subnet_group_name            = aws_db_subnet_group.this.name
  deletion_protection             = var.mysqlDeletionProtection
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery", "general"]
  vpc_security_group_ids          = [aws_security_group.rds.id]

  tags = local.tags
}

# MySql db instance of cluster
resource "aws_rds_cluster_instance" "this" {
  auto_minor_version_upgrade = false
  count                      = var.mysqlNumberOfInstance
  identifier                 = "${var.env}-${local.tags.project-prefix}-db-${count.index}"
  cluster_identifier         = aws_rds_cluster.this.id
  instance_class             = var.mysqlInstanceClass
  engine                     = aws_rds_cluster.this.engine
  engine_version             = aws_rds_cluster.this.engine_version
  tags                       = local.tags
}
