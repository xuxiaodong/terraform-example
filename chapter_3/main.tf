/*
 * 使用基础服务器模块
 */
provider "aws" {
  region = var.region
}

# 调用模块
module "ssh-key-name" {
  source = "./modules/prep-ssh"

  public_key = var.public_key
}

module "nginx-server" {
  source = "./modules/base-server"

  server_name   = "nginx-server"
  server_port   = 80
  server_script = templatefile("setup_nginx.sh", { time = timestamp() })
  region        = var.region
  amis          = var.amis
  instance_type = var.instance_type
  ssh_key_name  = module.ssh-key-name.key_name
}

module "ss-server" {
  source = "./modules/base-server"

  server_name   = "ss-server"
  server_port   = 8388
  server_script = templatefile("setup_ss.sh", { password = var.ss_password })
  region        = var.region
  amis          = var.amis
  instance_type = var.instance_type
  ssh_key_name  = module.ssh-key-name.key_name
}
