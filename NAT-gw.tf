resource "aws_eip" "nat" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.i-one-test ]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.i-one-test-public-zone-a.id # Attach to a public subnet
}
