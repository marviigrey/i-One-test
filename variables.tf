variable "ami" {
default = "ami-091f18e98bc129c4e"
description = "ami instance for ubuntu"
type = string
}

variable "instance_type" {
  default = "t2.micro"
}


variable "ec2-bastion-public-key-path" {
  type = string
}

variable "ec2-bastion-private-key-path" {
  type = string
}

variable "ec2-bastion-ingress-ip-1" {
  type = string
}

variable "frontend-public-key-path" {
  type = string
}

variable "frontend-private-key-path" {
  type = string
}
variable "aws_account_id" {
  type = number
}
variable "aws_region" {
  type = string
}
variable "secret_name" {
  type = string
}
output "public_ip" {
  value = aws_instance.i-one-bastion.public_ip
}
output "elastic-ip" {
  value = aws_eip.ec2-bastion-host-eip
}