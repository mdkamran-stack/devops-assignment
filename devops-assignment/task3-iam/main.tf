resource "aws_iam_group" "engine" { provider = aws.account_a
  name = "engine" }
resource "aws_iam_group" "ci" { provider = aws.account_a
  name = "ci" }
resource "aws_iam_user" "engine" {
  provider = aws.account_a
  for_each = local.engine_users
  name = each.value
  tags = { AccessType = "ProgrammaticOnly", ManagedBy = "Terraform" }
}
resource "aws_iam_user" "ci" {
  provider = aws.account_a
  for_each = local.ci_users
  name = each.value
  tags = { AccessType = "ProgrammaticOnly", ManagedBy = "Terraform" }
}
resource "aws_iam_group_membership" "engine" {
  provider = aws.account_a
  name = "engine-membership"
  group = aws_iam_group.engine.name
  users = [for user in aws_iam_user.engine : user.name]
}
resource "aws_iam_group_membership" "ci" {
  provider = aws.account_a
  name = "ci-membership"
  group = aws_iam_group.ci.name
  users = [for user in aws_iam_user.ci : user.name]
}
resource "aws_iam_group" "human_users" { provider = aws.account_a
  name = "human-users" }
resource "aws_iam_user" "human" {
  provider = aws.account_a
  for_each = local.human_users
  name = each.value
  tags = { AccessType = "ConsoleAndCLI", ManagedBy = "Terraform" }
}
resource "aws_iam_group_membership" "human_users" {
  provider = aws.account_a
  name = "human-users-membership"
  group = aws_iam_group.human_users.name
  users = [for user in aws_iam_user.human : user.name]
}
resource "aws_iam_role" "role_a" {
  provider = aws.account_a
  name = "roleA"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_a_id}:root" }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy" "role_a_permissions" {
  provider = aws.account_a
  name = "AllAwsActionsExceptIam"
  role = aws_iam_role.role_a.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Effect = "Allow", NotAction = "iam:*", Resource = "*" }]
  })
}
resource "aws_iam_role" "role_b" {
  provider = aws.account_b
  name = "roleB"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_b_id}:root" }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role" "role_c" {
  provider = aws.account_a
  name = "roleC"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_b_id}:role/roleB" }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy" "role_b_assume_c" {
  provider = aws.account_b
  name = "AssumeRoleC"
  role = aws_iam_role.role_b.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Effect = "Allow", Action = "sts:AssumeRole", Resource = aws_iam_role.role_c.arn }]
  })
}
resource "aws_iam_role_policy" "role_c_s3" {
  provider = aws.account_a
  name = "RoleCSpecificBucketAccess"
  role = aws_iam_role.role_c.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["s3:ListBucket", "s3:GetBucketLocation"], Resource = "arn:aws:s3:::${var.rolec_bucket_name}" },
      { Effect = "Allow", Action = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"], Resource = "arn:aws:s3:::${var.rolec_bucket_name}/*" }
    ]
  })
}
output "human_user_names" { value = sort([for user in aws_iam_user.human : user.name]) }
output "role_a_arn" { value = aws_iam_role.role_a.arn }
output "role_b_arn" { value = aws_iam_role.role_b.arn }
output "role_c_arn" { value = aws_iam_role.role_c.arn }
