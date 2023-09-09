variable "name" {
  description = "A friendly name for the Protection you are creating."
  type        = string
}

variable "resource_arn" {
  description = "The ARN (Amazon Resource Name) of the resource to be protected."
  type        = string
}

variable "protection_group_config" {
  description = <<EOF
  `id` - The name of the protection group, or protection_group_id
  `aggregation` - Defines how AWS Shield combines resource data for the group in order to detect, mitigate, and report events.
  `pattern` - The criteria to use to choose the protected resources for inclusion in the group.
  `resource_type` - (Optional) The resource type to include in the protection group. You must set this only when you set pattern to `BY_RESOURCE_TYPE`.
  EOF
  type = list(object({
    id            = string
    aggregation   = string
    pattern       = string
    resource_type = optional(string)
  }))
  validation {
    condition = alltrue([
      for config in var.protection_group_config : contains([
        "SUM",
        "MEAN",
        "MAX",
        ], config.aggregation) && contains([
        "ARBITRARY",
        "ALL",
        "BY_RESOURCE_TYPE",
        ], config.pattern) && contains([
        "APPLICATION_LOAD_BALANCER",
        "CLASSIC_LOAD_BALANCER",
        "CLOUDFRONT_DISTRIBUTION",
        "ELASTIC_IP_ALLOCATION",
        "GLOBAL_ACCELERATOR",
        "ROUTE_53_HOSTED_ZONE",
      ], config.resource_type) if config.resource_type != null
    ])
    error_message = <<EOF
    Valid values for `aggregation` are `SUM | MEAN | MAX`.
    Valid values for `pattern` are `ARBITRARY | ALL | BY_RESOURCE_TYPE`. You must declare `members` parameter when using the `ARBITRARY` pattern, using a list with the content of the `var.resource_arn`.
    Valid values for `resource_type` are `APPLICATION_LOAD_BALANCER | CLASSIC_LOAD_BALANCER | CLOUDFRONT_DISTRIBUTION | ELASTIC_IP_ALLOCATION | GLOBAL_ACCELERATOR | ROUTE_53_HOSTED_ZONE`.
    EOF
  }
}

variable "health_check_configuration" {
  description = "Amazon Route53 Health Check Configuration to be associated to AWS Shield Advanced Protection."
  type        = map(any)
  default     = null
}

variable "tags" {
  description = "Key-value map of resource tags to apply to all taggable resources created by the module. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level. Defaults to `{}`."
  type        = map(string)
  default     = {}
}
