output "vpc_security_group_id" {
  value = aws_security_group.postgres_public_access.id
}
