/*
 * 应用基础服务器模块 (含 count 元参数)
 */
provider "aws" {
  region = "ap-northeast-1"
}

module "ssh-key-name" {
  source = "../chapter_3/modules/prep-ssh"

  public_key = "../chapter_3/id_rsa.pub"
}

module "nginx-server" {
  source = "./modules/base-server-if"

  server_name   = "nginx-server"
  server_port   = 80
  server_script = templatefile("../chapter_3/setup_nginx.sh", { time = "Hello, 2019" })
  region        = "ap-northeast-1"
  amis          = { ap-northeast-1 = "ami-0cb1c8cab7f5249b6" }
  instance_type = "t2.micro"
  ssh_key_name  = module.ssh-key-name.key_name
}
