resource "aws_route_table" "i-one-test_public" {
  vpc_id = aws_vpc.main.id
}

# Separate route definition for public route table
resource "aws_route" "i-one-test_public_route" {
  route_table_id         = aws_route_table.i-one-test_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.i-one-test.id
}

resource "aws_route_table" "i-one-test_private" {
  vpc_id = aws_vpc.main.id
}

# Separate route definition for private route table (using NAT Gateway)
resource "aws_route" "i-one-test_private_route" {
  route_table_id         = aws_route_table.i-one-test_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Public Route Table Associations
resource "aws_route_table_association" "i-one-public-a" {
  subnet_id      = aws_subnet.i-one-test-public-zone-a.id
  route_table_id = aws_route_table.i-one-test_public.id
}

resource "aws_route_table_association" "i-one-public-b" {
  subnet_id      = aws_subnet.i-one-test-public-zone-b.id
  route_table_id = aws_route_table.i-one-test_public.id
}

# Private Route Table Associations
resource "aws_route_table_association" "i-one-private-a" {
  subnet_id      = aws_subnet.i-one-test-private-zone-a.id
  route_table_id = aws_route_table.i-one-test_private.id
}

resource "aws_route_table_association" "i-one-private-b" {
  subnet_id      = aws_subnet.i-one-test-private-zone-b.id
  route_table_id = aws_route_table.i-one-test_private.id
}
