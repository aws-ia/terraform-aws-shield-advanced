# Terraform Module for AWS Shield Advanced

Terraform module that creates AWS Shield Advanced Resources

- [Terraform Module for AWS Shield Advanced](#terraform-module-for-aws-shield-advanced)
  - [Usage](#usage)
  - [Overview Diagrams](#overview-diagrams)
  - [Terraform Module](#terraform-module)

## Usage

## Overview Diagrams

## Terraform Module

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_route53_health_check.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |
| [aws_shield_protection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/shield_protection) | resource |
| [aws_shield_protection_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/shield_protection_group) | resource |
| [aws_shield_protection_health_check_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/shield_protection_health_check_association) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | A friendly name for the Protection you are creating. | `string` | n/a | yes |
| <a name="input_protection_group_config"></a> [protection\_group\_config](#input\_protection\_group\_config) | `id` - The name of the protection group, or protection\_group\_id<br>  `aggregation` - Defines how AWS Shield combines resource data for the group in order to detect, mitigate, and report events.<br>  `pattern` - The criteria to use to choose the protected resources for inclusion in the group.<br>  `resource_type` - (Optional) The resource type to include in the protection group. You must set this only when you set pattern to `BY_RESOURCE_TYPE`. | <pre>list(object({<br>    id            = string<br>    aggregation   = string<br>    pattern       = string<br>    resource_type = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | The ARN (Amazon Resource Name) of the resource to be protected. | `string` | n/a | yes |
| <a name="input_health_check_configuration"></a> [health\_check\_configuration](#input\_health\_check\_configuration) | Amazon Route53 Health Check Configuration to be associated to AWS Shield Advanced Protection. | `map(any)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value map of resource tags to apply to all taggable resources created by the module. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level. Defaults to `{}`. | `map(string)` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_health_check"></a> [route53\_health\_check](#output\_route53\_health\_check) | Amazon Route53 Health Check Configuration. |
| <a name="output_shied_protection"></a> [shied\_protection](#output\_shied\_protection) | AWS Shield Advanced Protection and assigned resources. |
| <a name="output_shied_protection_group"></a> [shied\_protection\_group](#output\_shied\_protection\_group) | Group of protected resources to be collectivelly handled by AWS Shield Advanced. |
| <a name="output_shield_protection_health_check_association"></a> [shield\_protection\_health\_check\_association](#output\_shield\_protection\_health\_check\_association) | Association between an Amazon Route53 Health Check and an AWS Shield Advanced protected resource. |
