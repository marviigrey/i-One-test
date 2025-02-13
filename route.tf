resource "aws_route_table" "i-one-test_public" {
    vpc_id = aws_vpc.main.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.i-one-test.id
    }
  }

  resource "aws_route_table" "i-one-test_private" {
    vpc_id = aws_vpc.main.id
  }

  resource "aws_route_table_association" "i-one-public-a" {
    subnet_id = aws_subnet.i-one-test-public-zone-a.id
    route_table_id = aws_route_table.i-one-test_public.id
  }

  resource "aws_route_table_association" "i-one-public-b" {
    subnet_id = aws_subnet.i-one-test-public-zone-b.id
    route_table_id = aws_route_table.i-one-test_public.id
  }
  
  resource "aws_route_table_association" "i-one-private-a" {
    subnet_id = aws_subnet.i-one-test-private-zone-a.id
    route_table_id = aws_route_table.i-one-test_private.id
  }

  resource "aws_route_table_association" "i-one-private-a" {
    subnet_id = aws_subnet.i-one-test-private-zone-b.id
    route_table_id = aws_route_table.i-one-test_private.id
  }
  
  