/*
 * 测试基础服务器模块
 */
provider "aws" {
  region = "ap-northeast-1"
}

module "ssh-key-name" {
  source = "../modules/prep-ssh"

  public_key = "../id_rsa.pub"
}

module "nginx-server" {
  source = "../modules/base-server"

  server_name   = "nginx-server"
  server_port   = 80
  server_script = templatefile("../setup_nginx.sh", { time = "Hello, 2019" })
  region        = "ap-northeast-1"
  amis          = { ap-northeast-1 = "ami-0cb1c8cab7f5249b6" }
  instance_type = "t2.micro"
  ssh_key_name  = module.ssh-key-name.key_name
}
