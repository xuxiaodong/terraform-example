output "DNS" {
  value       = aws_instance.web.public_dns
  description = "AWS EC2 public DNS"
}

output "IP" {
  value       = aws_instance.web.public_ip
  description = "AWS EC2 public IP"
}
