
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    name = "i-one-test"
  }
}
resource "aws_vpc_endpoint" "backend-ssm" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ssm"
  private_dns_enabled = true
  vpc_endpoint_type = "Interface"
  subnet_ids = [
    aws_subnet.i-one-test-private-zone-a.id,
    aws_subnet.i-one-test-private-zone-b.id
    
     ]
  security_group_ids = [aws_security_group.vpce_sg.id]
  tags = {
    environment = "staging"
  }
}

resource "aws_vpc_endpoint" "backend-ssm_messages" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true 
  subnet_ids = [
    aws_subnet.i-one-test-private-zone-a.id,
    aws_subnet.i-one-test-private-zone-b.id
    
     ]

  tags = {
    environment = "staging"
  }


}

resource "aws_vpc_endpoint" "backend-ssm_ec2_messages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [
    aws_subnet.i-one-test-private-zone-a.id,
   aws_subnet.i-one-test-private-zone-b.id
    ]
  security_group_ids  = [aws_security_group.vpce_sg.id]

  tags = {
   environment = "staging"
  }
}

resource "aws_security_group" "vpce_sg" {
  name        = "vpce-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    environment = "staging"
  }
}