variable "aws_region" { type = string
  default = "us-west-2" }
variable "account_a_profile" { type = string
  default = "account-a" }
variable "account_b_profile" { type = string
  default = "account-b" }
variable "account_a_id" {
  type = string
  validation { condition = can(regex("^[0-9]{12}$", var.account_a_id))
  error_message = "Must be a 12-digit account ID." }
}
variable "account_b_id" {
  type = string
  validation { condition = can(regex("^[0-9]{12}$", var.account_b_id))
  error_message = "Must be a 12-digit account ID." }
}
variable "rolec_bucket_name" { type = string
  description = "Existing bucket in Account A" }
