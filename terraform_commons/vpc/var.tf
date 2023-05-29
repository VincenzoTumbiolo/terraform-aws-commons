# Input of module


variable "project_prefix" {
  type        = string
  description = "environment of deploy"
  default     = "otokiosk"
}

variable "env" {
  type        = string
  description = "environment of deploy"
}

variable "region" {
  type        = string
  description = "region for apply"
}

variable "vpc_ip" {
  type        = string
  description = "base ip for vpc"
}

variable "vpc_sub_mask_dimension" {
  type        = string
  description = "account id of aws user"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("[8-9]$|1[0-9]$|2[0-9]$|3[0-2]$", var.vpc_sub_mask_dimension))
    error_message = "allowe values are from 8 to 32."
  }
}

variable "subnet_sub_mask_dimension" {
  type        = string
  description = "account id of aws user"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("[8-9]$|1[0-9]$|2[0-9]$|3[0-2]$", var.subnet_sub_mask_dimension))
    error_message = "allow values are from 8 to 32."
  }
}