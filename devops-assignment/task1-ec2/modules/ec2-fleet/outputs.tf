output "instance_ids" {
  value = merge(
    { for name, instance in aws_instance.regular : name => instance.id },
    { for name, instance in aws_instance.protected : name => instance.id }
  )
}
output "private_ips" {
  value = merge(
    { for name, instance in aws_instance.regular : name => instance.private_ip },
    { for name, instance in aws_instance.protected : name => instance.private_ip }
  )
}
