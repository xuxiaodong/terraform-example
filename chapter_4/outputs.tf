output "ip" {
  value       = module.nginx-server.ip
  description = "NGINX web server ip address"
}

output "dns" {
  value       = module.nginx-server.dns
  description = "AWS EIP DNS"
}
