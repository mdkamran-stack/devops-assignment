resource "aws_iam_role" "role_c" {
  name = "roleC"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { AWS = "arn:aws:iam::444455556666:role/roleB" }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy" "role_c_s3" {
  name = "RoleCSpecificBucketAccess"
  role = aws_iam_role.role_c.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["s3:ListBucket", "s3:GetBucketLocation"], Resource = "arn:aws:s3:::replace-with-bucket-name" },
      { Effect = "Allow", Action = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"], Resource = "arn:aws:s3:::replace-with-bucket-name/*" }
    ]
  })
}
