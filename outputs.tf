output "shied_protection" {
  description = "AWS Shield Advanced Protection and assigned resources."
  value       = aws_shield_protection.this
}

output "shied_protection_group" {
  description = "Group of protected resources to be collectivelly handled by AWS Shield Advanced."
  value       = aws_shield_protection_group.this
}

output "route53_health_check" {
  description = "Amazon Route53 Health Check Configuration."
  value       = aws_route53_health_check.this
}

output "shield_protection_health_check_association" {
  description = "Association between an Amazon Route53 Health Check and an AWS Shield Advanced protected resource."
  value       = aws_shield_protection_health_check_association.this
}
