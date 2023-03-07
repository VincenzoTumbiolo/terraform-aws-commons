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




variable "atlasProjectId" {
  type        = string
  description = "progect Id of atlas db"
}

variable "dbUser" {
  type        = string
  description = "progect Id of atlas db"
}

variable "dbPassword" {
  type        = string
  description = "progect Id of atlas db"
}

variable "databaseName" {
  type        = string
  description = "progect Id of atlas db"
}




variable "atlasdb_major_version" {
  type        = string
  description = "version of atlas db cluster"
}
variable "atlasdb_cluster_type" {
  type        = string
  description = "type of atlas db cluster"
}
variable "atlasdb_disk_size_gb" {
  type        = string
  description = "size of atlas db cluster"
}
variable "atlasdb_provider_instance_size_name" {
  type        = string
  description = "provider instance size name of atlas db cluster"
}
variable "lambda_message_processor_memory_size" {
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
    project_prefix = "${replace(var.project_prefix, "-", "_")}-analytics"
    project-prefix = "${replace(var.project_prefix, "_", "-")}-analytics"
  }
}
