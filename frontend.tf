#backend Ec2 server. 
resource "aws_instance" "i-one-backend" {
  ami = var.ami
  key_name = aws_key_pair.ec2-bastion-host-key.key_name
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  subnet_id = aws_subnet.i-one-test-private-zone-a.id
  associate_public_ip_address = false
  vpc_security_group_ids = [ aws_security_group.backend_sg.id ]
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
    Name = "i-one-backend"
  }
  lifecycle {
    ignore_changes = [ 
      associate_public_ip_address,
     ]
  }

}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for backend instance"
  vpc_id      = aws_vpc.main.id

  # Allow incoming traffic on your API port(s)
  ingress {
    from_port   = 8080  
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]  
  }

  # Allow outbound traffic to VPC endpoints
  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.vpce_sg.id]
  }

  # Allow any other outbound traffic your backend needs
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]  # Restrict to VPC
  }
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]  # Allow SSH only from within VPC
    # Alternative: cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (less secure)
  }
  tags = {
    environment = "staging"
  }
}