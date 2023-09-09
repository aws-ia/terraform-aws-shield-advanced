provider "aws" {}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  arn_prefix = "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:eip-allocation"
}

resource "aws_eip" "example" {
  domain = "vpc"
}



module "shield_advanced" {
  source = "../.."

  name         = "Example protection"
  resource_arn = "${local.arn_prefix}/${aws_eip.example.id}"

  protection_group_config = [
    {
      id          = "Arbitrary Resource"
      aggregation = "MEAN"
      pattern     = "ARBITRARY"
      members     = "${local.arn_prefix}/${aws_eip.example.id}"
    },
    {
      id          = "All Resources"
      aggregation = "MEAN"
      pattern     = "ALL"
    },
    {
      id            = "CloudFront Resource"
      aggregation   = "SUM"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "CLOUDFRONT_DISTRIBUTION"
    },
    {
      id            = "Route53 Resource"
      aggregation   = "MAX"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "ROUTE_53_HOSTED_ZONE"
    },
    {
      id            = "GlobalAccelerator Resource"
      aggregation   = "SUM"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "GLOBAL_ACCELERATOR"
    },
    {
      id            = "ALB Resource"
      aggregation   = "MEAN"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "APPLICATION_LOAD_BALANCER"
    },
    {
      id            = "CLB Resource"
      aggregation   = "MEAN"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "CLASSIC_LOAD_BALANCER"
    },
    {
      id            = "ElasticIP Resource"
      aggregation   = "SUM"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "ELASTIC_IP_ALLOCATION"
    },
  ]

}
