output "ip" {
  value       = aws_instance.server.public_ip
  description = "AWS EC2 public IP"
}
