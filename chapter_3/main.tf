/*
 * 创建 AWS EC2 实例
 * 搭建 SS 服务
 */
provider "aws" {
  region = var.region
}

data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

# 创建 EC2 实例，运行 Docker 容器
resource "aws_instance" "ss" {
  ami           = lookup(var.amis, var.region)
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name
  tags = {
    Name = "ss-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y docker.io",
      "sudo docker run -e PASSWORD=${var.ss_password} -p 8388:8388 -p 8388:8388/udp -d shadowsocks/shadowsocks-libev",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("id_rsa")
      host        = aws_instance.ss.public_ip
    }
  }
}

# 添加 SSH 登录密钥
resource "aws_key_pair" "ssh" {
  key_name   = "admin"
  public_key = file(var.public_key)
}

# 开放 22 端口，允许 SSH 登录
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_groups.default.ids[0]
}

# 开放 8388 端口，允许 SS 访问
resource "aws_security_group_rule" "ss" {
  type              = "ingress"
  from_port         = 8388
  to_port           = 8388
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_groups.default.ids[0]
}
