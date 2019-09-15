/*
 * 基础服务器模块
 */
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

# 创建 EC2 实例
resource "aws_instance" "server" {
  ami           = lookup(var.amis, var.region)
  instance_type = var.instance_type
  key_name      = var.ssh_key_name
  user_data     = var.server_script
  tags = {
    Name = var.server_name
  }
}

# 开放其它端口
resource "aws_security_group_rule" "other" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_groups.default.ids[0]
}
