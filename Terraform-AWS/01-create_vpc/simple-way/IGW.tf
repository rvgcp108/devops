## Create Internet gateway
resource "aws_internet_gateway" "gw" {
  depends_on = [
    aws_vpc.prod,
    aws_subnet.private_subnets,
    aws_subnet.public_subnets
  ]
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "Prod VPC IGW"
  }
}
