# Input of module

variable "tags" {
  description = "A mapping of tags to assign to resources."
}

variable "lambda_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to lambda resources."
}

variable "cloudwatch_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to cloudwatch resources."
}

variable "cloudwatch_alarm_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to cloudwatch resources."
}

variable "build_command" {
  description = "This is the build command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables."
  type        = string
  default     = ""
}

variable "build_triggers" {
  description = "A map of values which should cause the build command to re-run. Values are meant to be interpolated references to variables or attributes of other resources."
  default = {
    always_run = "${timestamp()}"
  }
}

variable "source_dir" {
  description = "A path to the directory which contains source files builded."
  type        = string
  default     = null
}

variable "source_file" {
  description = "A file which contains source files builded."
  type        = string
  default     = null
}

variable "working_dir" {
  description = "A path to the directory which contains source files to build."
  type        = string
}

variable "output_path" {
  description = "A path to which the source directory is archived before uploading to AWS."
  type        = string
}

variable "function_name" {
  description = "A unique name for your Lambda Function."
  type        = string
}

variable "architecture" {
  type        = string
  description = "The architecture of the function's runtime."
  default     = "x86_64"
}

variable "runtime" {
  type        = string
  description = "The identifier of the function's runtime."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
}

variable "memory_size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default     = 128
}

variable "timeout" {
  type        = number
  description = "The maximum number of seconds the lambda function to run until timeout."
  default     = 3
}

variable "environment" {
  description = "A map that defines environment variables for the Lambda function."
  type = object({
    variables = map(string)
  })
  default = null
}

variable "dead_letter_config" {
  description = "Nested block to configure the function's dead letter queue."
  type = object({
    target_arn = string
  })
  default = null
}

variable "description" {
  type        = string
  description = "Description of what your Lambda Function does."
  default     = ""
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = []
}

variable "vpc_config" {
  description = "Provide this to allow your function to access your VPC."
  default     = null
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  type        = string
  default     = -1
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  type        = string
  default     = false
}

variable "tracing_config" {
  description = "Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with \"sampled=1\". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  type = object({
    mode = string
  })
  default = null
}

variable "project_prefix" {
  default     = ""
  description = "prefix"
  type        = string
}

variable "log_retention" {
  default     = 60
  description = "log retention"
}
variable "iam_role_arn" {
  description = "The arn of IAM role for the lambda function."
  type        = string
  default     = ""
}

variable "env" {
  type        = string
  description = "Enviroment stage."
}
