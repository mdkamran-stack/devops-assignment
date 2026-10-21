terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" { alias = "account_a"
  region = var.aws_region
  profile = var.account_a_profile }
provider "aws" { alias = "account_b"
  region = var.aws_region
  profile = var.account_b_profile }
