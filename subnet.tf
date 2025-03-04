resource "aws_subnet" "i-one-test-public-zone-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "i-one-test-public-sub-a"
  }

}
resource "aws_subnet" "i-one-test-private-zone-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "i-one-test-private-sub-a"
  }

}

resource "aws_subnet" "i-one-test-public-zone-b" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "i-one-test-public-sub-b"
  }

}

resource "aws_subnet" "i-one-test-private-zone-b" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    env = "i-one-test-private-sub-b"
  }

}


