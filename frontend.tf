#frontend Ec2 server. 
resource "aws_instance" "i-one-frontend" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.i-one-test-private-zone-a.id
  associate_public_ip_address = false
  vpc_security_group_ids = [ aws_security_group.i-one-frontend.id ]
  root_block_device {
    volume_size = 30
    delete_on_termination = true
    volume_type = "gp2"
    encrypted = true
    tags = {
      Name = "i-one-frontend"
    }
  }
  credit_specification {
    cpu_credits = "standard"
  }
  tags = {
    Name = "i-one-frontend"
  }
  lifecycle {
    ignore_changes = [ 
      associate_public_ip_address,
     ]
  }

}

resource "aws_security_group" "i-one-frontend" {
  vpc_id = aws_vpc.main.id
  name = "i-one-frontend"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ aws_security_group.i-one-bastion.id ]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "tls_private_key" "frontend-key-pair" {
  algorithm = "RSA"
  rsa_bits = 4096
}

## Create the file for Public Key
resource "local_file" "frontend-public-key" {
  depends_on = [ tls_private_key.frontend-key-pair ]
  content = tls_private_key.frontend-key-pair.public_key_openssh
  filename = var.frontend-public-key-path
}

resource "local_sensitive_file" "frontend-private-key" {
    depends_on = [ tls_private_key.frontend-key-pair ]
    content = tls_private_key.frontend-key-pair.private_key_pem
    file_permission = "0600"
    filename = var.frontend-private-key-path
}

resource "aws_key_pair" "frontend-key" {
  depends_on = [ local_file.frontend-public-key ]
  key_name = "frontend-key-pair"
  public_key = tls_private_key.frontend-key-pair.public_key_openssh
}