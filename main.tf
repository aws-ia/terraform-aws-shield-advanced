locals {
  tags = {
    Repository = "https://github.com/aws-ia/terraform-aws-shield-advanced"
  }
}

##################################################
# Shield Advanced Protection
##################################################
resource "aws_shield_protection" "this" {
  name         = var.name
  resource_arn = var.resource_arn
  tags = merge(
    local.tags,
    var.tags
  )
}

resource "aws_shield_protection_group" "this" {
  for_each = var.protection_group_config != null ? { for config in var.protection_group_config : config.id => config } : {}

  protection_group_id = each.value.id
  aggregation         = each.value.aggregation
  pattern             = each.value.pattern
  resource_type       = each.value.resource_type
  members             = try([var.resource_arn], [])
  tags = merge(
    local.tags,
    var.tags
  )

  depends_on = [aws_shield_protection.this]
}

##################################################
# Health Check
##################################################
resource "aws_route53_health_check" "this" {
  for_each          = var.health_check_configuration == null ? {} : var.health_check_configuration
  ip_address        = each.value.resource_ip
  port              = each.value.health_check_port
  type              = each.value.health_check_type
  resource_path     = each.value.health_check_path
  failure_threshold = each.value.health_check_threshold
  request_interval  = each.value.health_check_interval

  tags = merge(
    local.tags,
    var.tags
  )
}

resource "aws_shield_protection_health_check_association" "this" {
  for_each             = aws_route53_health_check.this
  health_check_arn     = aws_route53_health_check.this[each.key].arn
  shield_protection_id = aws_shield_protection.this.id
}
