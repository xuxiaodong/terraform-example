/*
 * 准备 SSH
 */
data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
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
