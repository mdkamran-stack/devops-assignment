terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}
provider "aws" { region = var.aws_region }
module "ec2_fleet" {
  source    = "./modules/ec2-fleet"
  instances = var.instances
}
