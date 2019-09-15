variable "region" {
  type        = string
  default     = "ap-northeast-1"
  description = "AWS region"
}

variable "amis" {
  type = map
  default = {
    ap-northeast-1 = "ami-0cb1c8cab7f5249b6"
  }
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "public_key" {
  type        = string
  default     = "id_rsa.pub"
  description = "SSH public key"
}

variable "ss_password" {
  type        = string
  description = "SS password"
}
