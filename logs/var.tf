# This file contains all variables used from infrastructure.
# This variables represent the value of environments.

variable "env" {
  type        = string
  description = "environment of deploy"
}

variable "project_prefix" {
  type        = string
  description = "environment of deploy"
}

variable "region" {
  type        = string
  description = "region for apply"
}

variable "accountId" {
  type        = string
  description = "account id of aws user"
}

variable "vpcId" {
  type        = string
  description = "vpc id"
}



variable "isolatedSubnetIdsString" {
  type        = string
  description = "list of isolated subnet id"
}

variable "privateSubnetIdsString" {
  type        = string
  description = "list of private subnet id"
}

variable "publicSubnetIdsString" {
  type        = string
  description = "list of public subnet id"
}



variable "mysqlAllocatedStorage" {
  type        = number
  description = "allocated storage for MySql database"
}

variable "mysqlEngine" {
  type        = string
  description = "engine for MySql database"
}

variable "mysqlEngineVersion" {
  type        = string
  description = "engine version for MySql database"
}

variable "mysqlInstanceClass" {
  type        = string
  description = "instance class for MySql database"
}

variable "mysqlName" {
  type        = string
  description = "name for MySql database"
}

variable "mysqlUsername" {
  type        = string
  description = "username for MySql database"
}

variable "mysqlPassword" {
  type        = string
  description = "password for MySql database"
}

variable "mysqlPort" {
  type        = number
  description = "port for MySql database"
}

variable "mysqlBackupRetention" {
  type        = number
  description = "The days to retain backups for"
}

variable "mysqlNumberOfInstance" {
  type        = number
  description = "Number of instances of MySql database"
}

variable "mysqlPreferredBackupTime" {
  type        = string
  description = "preferred time window for backup"
}

variable "mysqlDeletionProtection" {
  type        = bool
  description = "boolean to allow delete protection"
}

variable "mysqlSkipFinalSnapshot" {
  type        = bool
  description = "boolean to allow to skip final snapshot"
}

variable "mysqlBastionHostSgId" {
  description = "security group of bastion host"
}



variable "lambda_log_processor_memory_size" {
  type = number
}



# local variables are specific to each project
locals {
  isolatedSubnetIds     = split(",", "${var.isolatedSubnetIdsString}")
  privateSubnetIds      = split(",", "${var.privateSubnetIdsString}")
  publicSubnetIds       = split(",", "${var.publicSubnetIdsString}")
  cloudWatch-log-tags   = {}
  cloudWatch-alarm-tags = {}
  lambda_tags           = {}
  tags = {
    environment    = var.env
    createdBy      = "Terraform"
    project_prefix = "${replace(var.project_prefix, "-", "_")}-logs"
    project-prefix = "${replace(var.project_prefix, "_", "-")}-logs"
  }
}
