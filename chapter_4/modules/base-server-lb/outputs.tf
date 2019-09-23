output "ip" {
  value       = join("\n", aws_instance.server[*].public_ip)
  description = "AWS EC2 public IP"
}

output "dns" {
  value       = aws_eip.lb.public_dns
  description = "AWS EIP DNS"
}
