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

  name                = "Example protection"
  resource_arn        = "${local.arn_prefix}/${aws_eip.example.id}"
  protection_group_id = "example"
  aggregation         = "MEAN"
  pattern             = "ARBITRARY"
}
