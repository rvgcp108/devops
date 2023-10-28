output "aws_instance" {
  value = aws_instance.web1.id
}

output "aws_security_group" {
  value = aws_security_group.allow-tcp.id
}
