variable "region" {
  type        = string
  description = "AWS region"
}

variable "amis" {
  type        = map
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name"
}

variable "server_name" {
  type        = string
  description = "Server name"
}

variable "server_port" {
  type        = number
  description = "Server port"
}

variable "server_script" {
  type        = string
  description = "Server post run script"
}
