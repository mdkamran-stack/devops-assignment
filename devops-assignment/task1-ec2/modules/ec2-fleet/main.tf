locals {
  protected_name = "prod-db-01"
  protected_instances = { for name, cfg in var.instances : name => cfg if name == local.protected_name }
  regular_instances   = { for name, cfg in var.instances : name => cfg if name != local.protected_name }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter { name = "name"
  values = ["al2023-ami-*-x86_64"] }
  filter { name = "architecture"
  values = ["x86_64"] }
  filter { name = "virtualization-type"
  values = ["hvm"] }
}
resource "aws_instance" "regular" {
  for_each      = local.regular_instances
  ami           = data.aws_ami.amazon_linux.id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops = contains(["io1", "io2", "gp3"], each.value.volume_type) ? each.value.iops : null
  }
  tags = { Name = each.key, Environment = each.value.environment, Owner = each.value.owner }
}
resource "aws_instance" "protected" {
  for_each      = local.protected_instances
  ami           = data.aws_ami.amazon_linux.id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops = contains(["io1", "io2", "gp3"], each.value.volume_type) ? each.value.iops : null
  }
  tags = { Name = each.key, Environment = each.value.environment, Owner = each.value.owner }
  lifecycle { prevent_destroy = true }
}
