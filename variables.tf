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