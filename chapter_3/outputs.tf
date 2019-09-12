output "IP" {
  value       = aws_instance.ss.public_ip
  description = "AWS EC2 public IP"
}
