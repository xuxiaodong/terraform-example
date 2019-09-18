output "ip" {
  value       = join("\n", [aws_instance.server["dev"].public_ip, aws_instance.server["test"].public_ip])
  description = "AWS EC2 public IP"
}
