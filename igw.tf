resource "aws_internet_gateway" "i-one-test" {
  vpc_id = aws_vpc.main.id
  tags = {
    Env = "i-One-test"
  }
}