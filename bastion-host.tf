resource "aws_instance" "i-one-bastion" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.i-one-test-public-zone-a.id
  associate_public_ip_address = false
  vpc_security_group_ids = [ aws_security_group.i-one-bastion.id ]
  key_name = aws_key_pair.ec2-bastion-host-key.key_name
  root_block_device {
    volume_size = 8
    delete_on_termination = true
    volume_type = "gp2"
    encrypted = true
    tags = {
      Name = "i-one-test"
    }
  }
  credit_specification {
    cpu_credits = "standard"
  }
  tags = {
    Name = "i-one-test"
  }
  lifecycle {
    ignore_changes = [ 
      associate_public_ip_address,
     ]
  }

}

resource "aws_security_group" "i-one-bastion" {
  vpc_id = aws_vpc.main.id
  name = "bastion-i-one"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ec2-bastion-ingress-ip-1]
    description = "open to public internet"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks      = ["::/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "IPV4 open to public"
  }

}

#elastic ip for bastion host
resource "aws_eip" "ec2-bastion-host-eip" {
 domain = "vpc"
 instance = aws_instance.i-one-bastion.id

}

#associate elastic ip to EC2 bastion host
resource "aws_eip_association" "ec2-bastion-host-aws_eip_association" {
  instance_id = aws_instance.i-one-bastion.id
  allocation_id = aws_eip.ec2-bastion-host-eip.id
}
