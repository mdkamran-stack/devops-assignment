resource "aws_s3_bucket" "my_s3" {
  bucket_prefix = "terraform-state-demo-artifacts-"
  tags = { Name = "terraform-state-demo-artifacts", ManagedBy = "Terraform" }
}
