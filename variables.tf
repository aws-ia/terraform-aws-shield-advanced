variable "name" {
  description = "A friendly name for the Protection you are creating."
  type        = string
}

variable "resource_arn" {
  description = "The ARN (Amazon Resource Name) of the resource to be protected."
  type        = string
}

variable "protection_group_id" {
  description = "The name of the protection group."
  type        = string
}

variable "aggregation" {
  description = "Defines how AWS Shield combines resource data for the group in order to detect, mitigate, and report events."
  type        = string
}

variable "pattern" {
  description = "The criteria to use to choose the protected resources for inclusion in the group."
  type        = string
}

variable "resource_type" {
  description = "The resource type to include in the protection group. This is required if `pattern` is set to BY_RESOURCE_TYPE. Otherwise this must be not set. Defaults to `null`"
  type        = string
  default     = null
}

variable "health_check_configuration" {
  description = "Amazon Route53 Health Check Configuration to be associated to AWS Shield Advanced Protection."
  type        = map(any)
  default     = null
}

variable "tags" {
  description = "Key-value map of resource tags. Defaults to `{}`"
  type        = map(string)
  default     = {}
}
