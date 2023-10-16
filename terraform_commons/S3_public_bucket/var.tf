# Input of module


variable "s3_name" {
  type        = string
  description = "name for s3 bucket"
}

variable "versioned" {
  type        = bool
  description = "Enables versioning of bucket"
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
}
