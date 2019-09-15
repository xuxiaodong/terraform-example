output "WEB_IP" {
  value       = module.nginx-server.ip
  description = "NGINX web server ip address"
}

output "SS_IP" {
  value       = module.ss-server.ip
  description = "Shadowsocks server ip address"
}
