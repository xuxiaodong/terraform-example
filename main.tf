/*
 * 创建 AWS EC2 实例
 * 允许通过 SSH 登录
 */
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "web" {
  ami           = "ami-a3ed72c5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh.key_name
}

# 添加 SSH 登录密钥
resource "aws_key_pair" "ssh" {
  key_name   = "admin"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA1u/s1R3zGuK1p1xoVwVqd0IjYTYLTIITCL5a/b2tfPunwUKNlKqq9wzdPhHMlGer6yRQvavPTnnoTQZruAB/a4ZHqi2uH9GJRk7IkPHPaKFnNZz9F2mUiG06kecOAqwiZs2+LRNR9qRBIC7BK3K7YUlJ3trVlcwpZGxKTfMcOdGGvFrR90BSLklihTMsUWJmkfNjYar4jW0LBm4Ng9dxm3VS8GZHJtF7TFJmLFhF5gjUdn9gszvsDevwy7B5LGE+lDXdMl0VRQ8/KM6jD4FxtvL/qwaMNH/8LaVjdtV+Hb7qqpIIrrF9f6oXvNjVlm1X8B2GE7uPPfi4jYGv8G2R5Q== for mt host"
}

// 开放 22 端口，允许 SSH 登录
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "sg-a361e5da"
}
