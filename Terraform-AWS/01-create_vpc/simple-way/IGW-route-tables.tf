## Route table for Public Subnet
resource "aws_route_table" "public_subnet_routing" {
  depends_on = [aws_vpc.prod, aws_internet_gateway.gw]
  vpc_id     = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}

# Associating Route Table to Public Subnets 
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_subnet_routing.id
}
